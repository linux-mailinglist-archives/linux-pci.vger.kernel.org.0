Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAFC791A53
	for <lists+linux-pci@lfdr.de>; Mon,  4 Sep 2023 17:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348440AbjIDPK4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Sep 2023 11:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjIDPKu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Sep 2023 11:10:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90497E6C;
        Mon,  4 Sep 2023 08:10:40 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RfXBd2w0dz6K6l9;
        Mon,  4 Sep 2023 23:10:33 +0800 (CST)
Received: from localhost (10.48.153.57) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 4 Sep
 2023 16:10:37 +0100
Date:   Mon, 4 Sep 2023 16:10:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alistair Francis <alistair23@gmail.com>
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <lukas@wunner.de>, <alex.williamson@redhat.com>,
        <christian.koenig@amd.com>, <kch@nvidia.com>,
        <gregkh@linuxfoundation.org>, <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <chaitanyak@nvidia.com>,
        <rdunlap@infradead.org>,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v7 1/3] PCI/DOE: Rename DOE protocol to feature
Message-ID: <20230904161036.00005ea5@Huawei.com>
In-Reply-To: <20230904054329.865151-1-alistair.francis@wdc.com>
References: <20230904054329.865151-1-alistair.francis@wdc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.153.57]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon,  4 Sep 2023 15:43:27 +1000
Alistair Francis <alistair23@gmail.com> wrote:

> DOE r1.1 replaced all occurrences of "protocol" with the term "feature"
> or "Data Object Type".
> 
> PCIe r6.1 (which was published July 24) incorporated that change.
> 
> This patch renames the existing terms protocol with feature.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Hi Alastair.

I'm fine with updating this but if we are going to do so I tink we need
to catch all of them including variable names from prot -> feat etc

Jonathan

> ---
> v7:
>  - Initial patch
> 
>  drivers/pci/doe.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index e3aab5edaf70..047be8c9d191 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -43,7 +43,7 @@
>   *
>   * @pdev: PCI device this mailbox belongs to
>   * @cap_offset: Capability offset
> - * @prots: Array of protocols supported (encoded as long values)
> + * @prots: Array of features supported (encoded as long values)

feats?

>   * @wq: Wait queue for work item
>   * @work_queue: Queue of pci_doe_work items
>   * @flags: Bit array of PCI_DOE_FLAG_* flags
> @@ -58,7 +58,7 @@ struct pci_doe_mb {
>  	unsigned long flags;
>  };
>  
> -struct pci_doe_protocol {
> +struct pci_doe_feature {
>  	u16 vid;
>  	u8 type;
>  };
> @@ -66,7 +66,7 @@ struct pci_doe_protocol {
>  /**
>   * struct pci_doe_task - represents a single query/response
>   *
> - * @prot: DOE Protocol
> + * @prot: DOE Feature

Might be more churn, but probably worth renaming prot to feat or
similar as well!

>   * @request_pl: The request payload
>   * @request_pl_sz: Size of the request payload (bytes)
>   * @response_pl: The response payload
> @@ -78,7 +78,7 @@ struct pci_doe_protocol {
>   * @doe_mb: Used internally by the mailbox
>   */
>  struct pci_doe_task {
> -	struct pci_doe_protocol prot;
> +	struct pci_doe_feature prot;

Same here.  Very confusing to leave variable called prot.

>  	const __le32 *request_pl;
>  	size_t request_pl_sz;
>  	__le32 *response_pl;
> @@ -217,11 +217,11 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
>  	int i = 0;
>  	u32 val;
>  
> -	/* Read the first dword to get the protocol */
> +	/* Read the first dword to get the feature */
>  	pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
>  	if ((FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val) != task->prot.vid) ||
>  	    (FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val) != task->prot.type)) {
> -		dev_err_ratelimited(&pdev->dev, "[%x] expected [VID, Protocol] = [%04x, %02x], got [%04x, %02x]\n",
> +		dev_err_ratelimited(&pdev->dev, "[%x] expected [VID, Feature] = [%04x, %02x], got [%04x, %02x]\n",
>  				    doe_mb->cap_offset, task->prot.vid, task->prot.type,
>  				    FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val),
>  				    FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val));
> @@ -384,7 +384,7 @@ static void pci_doe_task_complete(struct pci_doe_task *task)
>  }
>  
>  static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> -			     u8 *protocol)
> +			     u8 *feature)
>  {
>  	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
>  				    *index);
> @@ -404,7 +404,7 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
>  
>  	response_pl = le32_to_cpu(response_pl_le);
>  	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
> -	*protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
> +	*feature = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
>  			      response_pl);
>  	*index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX,
>  			   response_pl);
> @@ -417,7 +417,7 @@ static void *pci_doe_xa_prot_entry(u16 vid, u8 prot)
>  	return xa_mk_value((vid << 8) | prot);
>  }
>  
> -static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
> +static int pci_doe_cache_features(struct pci_doe_mb *doe_mb)
>  {
>  	u8 index = 0;
>  	u8 xa_idx = 0;
> @@ -432,7 +432,7 @@ static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
>  			return rc;
>  
>  		pci_dbg(doe_mb->pdev,
> -			"[%x] Found protocol %d vid: %x prot: %x\n",
> +			"[%x] Found feature %d vid: %x prot: %x\n",

prot?

>  			doe_mb->cap_offset, xa_idx, vid, prot);
>  
>  		rc = xa_insert(&doe_mb->prots, xa_idx++,
> @@ -460,7 +460,7 @@ static void pci_doe_cancel_tasks(struct pci_doe_mb *doe_mb)
>   * @pdev: PCI device to create the DOE mailbox for
>   * @cap_offset: Offset of the DOE mailbox
>   *
> - * Create a single mailbox object to manage the mailbox protocol at the
> + * Create a single mailbox object to manage the mailbox feature at the
>   * cap_offset specified.
>   *
>   * RETURNS: created mailbox object on success
> @@ -502,11 +502,11 @@ static struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev,
>  
>  	/*
>  	 * The state machine and the mailbox should be in sync now;
> -	 * Use the mailbox to query protocols.
> +	 * Use the mailbox to query features.
>  	 */
> -	rc = pci_doe_cache_protocols(doe_mb);
> +	rc = pci_doe_cache_features(doe_mb);
>  	if (rc) {
> -		pci_err(pdev, "[%x] failed to cache protocols : %d\n",
> +		pci_err(pdev, "[%x] failed to cache features : %d\n",
>  			doe_mb->cap_offset, rc);
>  		goto err_cancel;
>  	}
> @@ -540,19 +540,19 @@ static void pci_doe_destroy_mb(struct pci_doe_mb *doe_mb)
>  
>  /**
>   * pci_doe_supports_prot() - Return if the DOE instance supports the given
> - *			     protocol
> + *			     feature
>   * @doe_mb: DOE mailbox capability to query
> - * @vid: Protocol Vendor ID
> - * @type: Protocol type
> + * @vid: Feature Vendor ID
> + * @type: Feature type
>   *
> - * RETURNS: True if the DOE mailbox supports the protocol specified
> + * RETURNS: True if the DOE mailbox supports the feature specified
>   */
>  static bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
>  {
>  	unsigned long index;
>  	void *entry;
>  
> -	/* The discovery protocol must always be supported */
> +	/* The discovery feature must always be supported */
>  	if (vid == PCI_VENDOR_ID_PCI_SIG && type == PCI_DOE_PROTOCOL_DISCOVERY)
>  		return true;
>  
> @@ -659,7 +659,7 @@ EXPORT_SYMBOL_GPL(pci_doe);
>   * @vendor: Vendor ID
>   * @type: Data Object Type
>   *
> - * Find first DOE mailbox of a PCI device which supports the given protocol.
> + * Find first DOE mailbox of a PCI device which supports the given feature.
>   *
>   * RETURNS: Pointer to the DOE mailbox or NULL if none was found.
>   */

