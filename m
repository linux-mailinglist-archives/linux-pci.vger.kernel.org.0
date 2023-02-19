Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D951D69C048
	for <lists+linux-pci@lfdr.de>; Sun, 19 Feb 2023 14:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjBSNDl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Feb 2023 08:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBSNDk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Feb 2023 08:03:40 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43185EC5A;
        Sun, 19 Feb 2023 05:03:36 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 5829F2803A014;
        Sun, 19 Feb 2023 14:03:32 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4BE2135CCE; Sun, 19 Feb 2023 14:03:32 +0100 (CET)
Date:   Sun, 19 Feb 2023 14:03:32 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 01/16] cxl/pci: Fix CDAT retrieval on big endian
Message-ID: <20230219130332.GA20728@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
 <bbbe1c4f3788052865941572565aeb2be67a6770.1676043318.git.lukas@wunner.de>
 <63e6dfd7cc162_1e4943294e9@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e6dfd7cc162_1e4943294e9@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 10, 2023 at 04:22:47PM -0800, Dan Williams wrote:
> Lukas Wunner wrote:
> > PCI Configuration Space is little endian (PCI r3.0 sec 6.1).  Accessors
> > such as pci_read_config_dword() implicitly swap bytes on big endian.
> > That way, the macros in include/uapi/linux/pci_regs.h work regardless of
> > the arch's endianness.  For an example of implicit byte-swapping, see
> > ppc4xx_pciex_read_config(), which calls in_le32(), which uses lwbrx
> > (Load Word Byte-Reverse Indexed).
> > 
> > DOE Read/Write Data Mailbox Registers are unlike other registers in
> > Configuration Space in that they contain or receive a 4 byte portion of
> > an opaque byte stream (a "Data Object" per PCIe r6.0 sec 7.9.24.5f).
> > They need to be copied to or from the request/response buffer verbatim.
> > So amend pci_doe_send_req() and pci_doe_recv_resp() to undo the implicit
> > byte-swapping.
[...]
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -143,7 +143,7 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
> >  					  length));
> >  	for (i = 0; i < task->request_pl_sz / sizeof(u32); i++)
> >  		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
> > -				       task->request_pl[i]);
> > +				       le32_to_cpu(task->request_pl[i]));
> 
> What do you think about defining:
> 
> int pci_doe_write(const struct pci_dev *dev, int where, __le32 val);
> int pci_doe_read(const struct pci_dev *dev, int where, __le32 *val);
> 
> ...local to this file to make it extra clear that DOE transfers are
> passing raw byte-streams and not register values as
> pci_{write,read}_config_dword() expect.

I've done a prototype (see below), but it doesn't strike me as an
improvement:

There are only two occurrences for each of those read and write accessors,
so the diffstat isn't pretty (27 insertions, 12 deletions).

Moreover, the request header constructed in pci_doe_send_req() is
constructed in native endianness and written using the standard
pci_write_config_dword() accessor.  Same for the response header
parsed in pci_doe_recv_resp().  Thus, the functions do not
consistently use the new custom accessors, but rather use a mix
of the standard accessors and custom accessors.  So clarity may
not improve all that much.

Let me know if you feel otherwise!

The patch below goes on top of the series.  I'm using a variation
of your suggested approach in that I've named the custom accessors
pci_doe_{write,read}_data() (for consistency with the existing
pci_doe_write_ctrl()).

Thanks,

Lukas

-- >8 --

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 8499cf9..6b0148e 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -106,6 +106,24 @@ static void pci_doe_write_ctrl(struct pci_doe_mb *doe_mb, u32 val)
 	pci_write_config_dword(pdev, offset + PCI_DOE_CTRL, val);
 }
 
+static void pci_doe_write_data(struct pci_doe_mb *doe_mb, __le32 lav)
+{
+	struct pci_dev *pdev = doe_mb->pdev;
+	int offset = doe_mb->cap_offset;
+
+	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE, le32_to_cpu(lav));
+}
+
+static void pci_doe_read_data(struct pci_doe_mb *doe_mb, __le32 *lav)
+{
+	struct pci_dev *pdev = doe_mb->pdev;
+	int offset = doe_mb->cap_offset;
+	u32 val;
+
+	pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
+	*lav = cpu_to_le32(val);
+}
+
 static int pci_doe_abort(struct pci_doe_mb *doe_mb)
 {
 	struct pci_dev *pdev = doe_mb->pdev;
@@ -144,6 +162,7 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
 	struct pci_dev *pdev = doe_mb->pdev;
 	int offset = doe_mb->cap_offset;
 	size_t length, remainder;
+	__le32 lav;
 	u32 val;
 	int i;
 
@@ -177,16 +196,14 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
 
 	/* Write payload */
 	for (i = 0; i < task->request_pl_sz / sizeof(__le32); i++)
-		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
-				       le32_to_cpu(task->request_pl[i]));
+		pci_doe_write_data(doe_mb, task->request_pl[i]);
 
 	/* Write last payload dword */
 	remainder = task->request_pl_sz % sizeof(__le32);
 	if (remainder) {
-		val = 0;
-		memcpy(&val, &task->request_pl[i], remainder);
-		le32_to_cpus(&val);
-		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE, val);
+		lav = 0;
+		memcpy(&lav, &task->request_pl[i], remainder);
+		pci_doe_write_data(doe_mb, lav);
 	}
 
 	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_GO);
@@ -211,6 +228,7 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
 	size_t length, payload_length, remainder, received;
 	struct pci_dev *pdev = doe_mb->pdev;
 	int offset = doe_mb->cap_offset;
+	__le32 lav;
 	int i = 0;
 	u32 val;
 
@@ -256,16 +274,13 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
 	if (payload_length) {
 		/* Read all payload dwords except the last */
 		for (; i < payload_length - 1; i++) {
-			pci_read_config_dword(pdev, offset + PCI_DOE_READ,
-					      &val);
-			task->response_pl[i] = cpu_to_le32(val);
+			pci_doe_read_data(doe_mb, &task->response_pl[i]);
 			pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
 		}
 
 		/* Read last payload dword */
-		pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
-		cpu_to_le32s(&val);
-		memcpy(&task->response_pl[i], &val, remainder);
+		pci_doe_read_data(doe_mb, &lav);
+		memcpy(&task->response_pl[i], &lav, remainder);
 		/* Prior to the last ack, ensure Data Object Ready */
 		if (!pci_doe_data_obj_ready(doe_mb))
 			return -EIO;
