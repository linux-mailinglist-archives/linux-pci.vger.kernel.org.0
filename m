Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFB154FEC7
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 23:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383608AbiFQUnF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 16:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383611AbiFQUmv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 16:42:51 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDE15DBCB;
        Fri, 17 Jun 2022 13:40:52 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9AC5D81C3D;
        Fri, 17 Jun 2022 20:40:50 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id EC95481BD3;
        Fri, 17 Jun 2022 20:40:49 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1655498450; a=rsa-sha256;
        cv=none;
        b=Tpd2yyDntqlMU2V3crqNRy7l32e+tOrYkOTu672CLdYmdsoRMG5tAdB+AZd5NormH7moWJ
        4l1DLWwWf5oK1u4MfN6knukpTeluw0VpFle8IYOzmTbJDOsMyiMf6uJA/VNSgEU2/igfFO
        L/U3sNXP+JOlTGr0WFpJdbv3+yluVYSfWOTnzWRgXg26i+0Lgg+x5hf83vzw50ZhoWnff+
        Vzcm3pT9QqEsaPCDL1VFqzAWby+YY8fkn/lqz+AtabchRpNPhTXnUlZbbOiELOHB4EclbV
        PULlOG3AnINgs30hB8Ff44aojerMmN0V/2KeOrTs3ztnvOtsMqsrGMX26yGB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1655498450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=lykkFNFOZt2FNRu8ye1JiltrQXiKX3YS6Z0KwMe5t+A=;
        b=a4GUn6f89hPru0lAdg6fp0olXpgGOm2LHGdc80pJuKw4cT+sDqQa5eVXOtdCK47fW5bOA8
        1YvjD6a68faw8UM92qx/eYAVv4sX/o5d5iIKaV8I+dbcAT7Bz1kFKKP5LWItlnPfyYGUTR
        fhNVSIsKSmZMajs+28vY1GSL/m6/tJprtQI9nwTp3bn/cknWUwsUfwFnGME4Z8dQKYedRi
        hlNEPVbGpAjOPc4ZgvCLEbZM1jOwVHa6JOo0sY33xs2a3+6CJu9WnlRaIN4eQD2RLA0aDu
        B3w40CsJ4oyY47JRbKeYgDuUctzvIR9+iMjhh6uWSJOqBNqOugO6BsenbvpORQ==
ARC-Authentication-Results: i=1;
        rspamd-848669fb87-5ggpz;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Dime-Bubble: 075ab45a0c46bfcc_1655498450381_1563642052
X-MC-Loop-Signature: 1655498450381:944370204
X-MC-Ingress-Time: 1655498450381
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.115.45.51 (trex/6.7.1);
        Fri, 17 Jun 2022 20:40:50 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LPrXc6zkPz23;
        Fri, 17 Jun 2022 13:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1655498449;
        bh=lykkFNFOZt2FNRu8ye1JiltrQXiKX3YS6Z0KwMe5t+A=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=hS7tj7gUaj5TRliMGlbeoU1+ope3BBKKY5DSoTT2PctnfK1AO16RI7XgznA2G8H0H
         ru+BrpZSdfz2JWdMKXeaqDiVEHcCr7IbkMvHudjTx4blAIKUaSyskAtCdkRmu/P0yX
         joOrhJ24RDAmqCFRdJVtEZfhDdFNfN8UrXZu9+ywIMUon1fFbKPck2Q6FJYns9IQEY
         VjhhcPJnLwZJhdMN4WnIH4en1Winrd2fixTLhVcTKoa8/X7xHlxjQECIkV2YESeQxw
         jcNBwxw2d7YrU4nDJbWeQL3pM7CahQD8p3lLV5JzxXUyfxi/ARt5yfEEfD6Nv10BMH
         dhugcMvqb7Zbg==
Date:   Fri, 17 Jun 2022 13:40:46 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "ira.weiny@intel.com" <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org, a.manzanares@samsung.com
Subject: Re: [PATCH v11 4/8] cxl/pci: Create PCI DOE mailbox's for memory
 devices
Message-ID: <20220617204046.qdkza6iemkfv2aze@offworld>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-5-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220610202259.3544623-5-ira.weiny@intel.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 10 Jun 2022, ira.weiny@intel.com wrote:
>+++ b/drivers/cxl/cxlmem.h
>@@ -191,6 +191,8 @@ struct cxl_endpoint_dvsec_info {
>  * @component_reg_phys: register base of component registers
>  * @info: Cached DVSEC information about the device.
>  * @serial: PCIe Device Serial Number

Missing doc:

@doe_use_irq: Use interrupt vectors for DOEs over polling.

However introducing such flags is not pretty, and this is only used by
devm_cxl_pci_create_doe(). Do we really need it? See below.

>+ * @doe_mbs: PCI DOE mailbox array
>+ * @num_mbs: Number of DOE mailboxes
>  * @mbox_send: @dev specific transport for transmitting mailbox commands
>  *
>  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
>@@ -224,6 +226,10 @@ struct cxl_dev_state {
>	resource_size_t component_reg_phys;
>	u64 serial;
>
>+	bool doe_use_irq;
>+	struct pci_doe_mb **doe_mbs;
>+	int num_mbs;
>+
>	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> };
>
>diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>index 5a0ae46d4989..72c7b535f5df 100644
>--- a/drivers/cxl/pci.c
>+++ b/drivers/cxl/pci.c
>@@ -8,6 +8,7 @@
> #include <linux/mutex.h>
> #include <linux/list.h>
> #include <linux/pci.h>
>+#include <linux/pci-doe.h>
> #include <linux/io.h>
> #include "cxlmem.h"
> #include "cxlpci.h"
>@@ -386,6 +387,116 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>	return rc;
> }
>
>+static void cxl_pci_free_irq_vectors(void *data)
>+{
>+	pci_free_irq_vectors(data);
>+}
>+
>+static void cxl_doe_destroy_mb(void *ds)
>+{
>+	struct cxl_dev_state *cxlds = ds;
>+	int i;
>+
>+	for (i = 0; i < cxlds->num_mbs; i++) {
>+		if (cxlds->doe_mbs[i])
>+			pci_doe_destroy_mb(cxlds->doe_mbs[i]);
>+	}
>+}
>+
>+static void cxl_alloc_irq_vectors(struct cxl_dev_state *cxlds)
>+{
>+	struct device *dev = cxlds->dev;
>+	struct pci_dev *pdev = to_pci_dev(dev);
>+	int max_irqs = 0;
>+	int off = 0;
>+	int rc;
>+
>+	/* Account for all the DOE vectors needed */
>+	pci_doe_for_each_off(pdev, off) {
>+		int irq = pci_doe_get_irq_num(pdev, off);
>+
>+		if (irq < 0)
>+			continue;
>+		max_irqs = max(max_irqs, irq + 1);
>+	}
>+
>+	if (!max_irqs)
>+		return;
>+
>+	cxlds->doe_use_irq = false;

Is this unnecessary, it should already be 0 per the devm_kzalloc().

>+
>+	/*
>+	 * Allocate enough vectors for the DOE's
>+	 */
>+	rc = pci_alloc_irq_vectors(pdev, max_irqs, max_irqs, PCI_IRQ_MSI |
>+							     PCI_IRQ_MSIX);
>+	if (rc != max_irqs) {
>+		pci_err(pdev, "Not enough interrupts; use polling\n");
>+		/* Some got allocated; clean them up */
>+		if (rc > 0)
>+			cxl_pci_free_irq_vectors(pdev);
>+		return;
>+	}
>+
>+	rc = devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
>+	if (rc)
>+		return;
>+
>+	cxlds->doe_use_irq = true;
>+}
>+
>+/**
>+ * devm_cxl_pci_create_doe - Scan and set up DOE mailboxes
>+ *
>+ * @cxlds: The CXL device state
>+ */
>+static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
>+{
>+	struct device *dev = cxlds->dev;
>+	struct pci_dev *pdev = to_pci_dev(dev);
>+	u16 off = 0;
>+	int num_mbs = 0;
>+	int rc;
>+
>+	pci_doe_for_each_off(pdev, off)
>+		num_mbs++;
>+
>+	if (!num_mbs) {
>+		pci_dbg(pdev, "0 DOE mailbox's found\n");
>+		return;
>+	}
>+
>+	cxlds->doe_mbs = devm_kcalloc(dev, num_mbs, sizeof(*cxlds->doe_mbs),
>+				      GFP_KERNEL);
>+	if (!cxlds->doe_mbs)
>+		return;
>+
>+	pci_doe_for_each_off(pdev, off) {
>+		struct pci_doe_mb *doe_mb;
>+		int irq = -1;
>+
>+		if (cxlds->doe_use_irq)
>+			irq = pci_doe_get_irq_num(pdev, off);
>+
>+		doe_mb = pci_doe_create_mb(pdev, off, irq);
>+		if (IS_ERR(doe_mb)) {
>+			pci_err(pdev,
>+				"Failed to create MB object for MB @ %x\n",
>+				off);
>+			doe_mb = NULL;
>+		}
>+
>+		cxlds->doe_mbs[cxlds->num_mbs] = doe_mb;
>+		cxlds->num_mbs++;
>+	}
>+
>+	rc = devm_add_action_or_reset(dev, cxl_doe_destroy_mb, cxlds);
>+	if (rc)
>+		return;
>+
>+	pci_info(pdev, "Configured %d DOE mailbox's\n", cxlds->num_mbs);
>+}
>+
> static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> {
>	struct cxl_register_map map;
>@@ -434,6 +545,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>
>	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);
>
>+	cxl_alloc_irq_vectors(cxlds);
>+	devm_cxl_pci_create_doe(cxlds);

Should cxl_alloc_irq_vectors() just be called directly from devm_cxl_pci_create_doe()
instead? Also if devm_cxl_pci_create_doe() fails (say ENOMEM), why do we
bother continuing the cxl_pci probing?

Thanks,
Davidlohr

------
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ce5b00f3ebcb..44098c785a8b 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -230,7 +230,6 @@ struct cxl_dev_state {
	resource_size_t component_reg_phys;
	u64 serial;

-	bool doe_use_irq;
	struct pci_doe_mb **doe_mbs;
	int num_mbs;

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 72c7b535f5df..47c3741f7768 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -403,7 +403,7 @@ static void cxl_doe_destroy_mb(void *ds)
	}
  }

-static void cxl_alloc_irq_vectors(struct cxl_dev_state *cxlds)
+static int cxl_alloc_irq_vectors(struct cxl_dev_state *cxlds)
  {
	struct device *dev = cxlds->dev;
	struct pci_dev *pdev = to_pci_dev(dev);
@@ -421,9 +421,7 @@ static void cxl_alloc_irq_vectors(struct cxl_dev_state *cxlds)
	}

	if (!max_irqs)
-		return;
-
-	cxlds->doe_use_irq = false;
+		return -ENOMEM;

	/*
	 * Allocate enough vectors for the DOE's
@@ -435,14 +433,10 @@ static void cxl_alloc_irq_vectors(struct cxl_dev_state *cxlds)
		/* Some got allocated; clean them up */
		if (rc > 0)
			cxl_pci_free_irq_vectors(pdev);
-		return;
+		return -ENOMEM;
	}

-	rc = devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
-	if (rc)
-		return;
-
-	cxlds->doe_use_irq = true;
+	return devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
  }

  /**
@@ -457,6 +451,10 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
	u16 off = 0;
	int num_mbs = 0;
	int rc;
+	bool doe_use_irq = false;
+
+	if (cxl_alloc_irq_vectors(cxlds))
+		doe_use_irq = true;

	pci_doe_for_each_off(pdev, off)
		num_mbs++;
@@ -475,7 +473,7 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
		struct pci_doe_mb *doe_mb;
		int irq = -1;

-		if (cxlds->doe_use_irq)
+		if (doe_use_irq)
			irq = pci_doe_get_irq_num(pdev, off);

		doe_mb = pci_doe_create_mb(pdev, off, irq);
@@ -545,7 +543,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)

	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);

-	cxl_alloc_irq_vectors(cxlds);
	devm_cxl_pci_create_doe(cxlds);

	rc = cxl_pci_setup_mailbox(cxlds);
