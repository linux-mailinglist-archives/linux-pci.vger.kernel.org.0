Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3D3539527
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 19:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346263AbiEaRBD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 13:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346264AbiEaRA7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 13:00:59 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6803719D1;
        Tue, 31 May 2022 10:00:56 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 51CC112272D;
        Tue, 31 May 2022 17:00:55 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 8F872121BFF;
        Tue, 31 May 2022 17:00:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1654016454; a=rsa-sha256;
        cv=none;
        b=F24bZ2ZwmHsonA8zMYYh9wcTT+ZHuZgK7eAFxQQ7gqszgOCD31xlzGwJBkxQHSkuAFEX2q
        mqQHpUoLvnvlpWFfCNtPz564lFVba2s/DQmAGCEaJlZ/Ny8lBjSgq0ncgFgrMyPlMEVIxr
        7j1DMQEoXy35EENRze1ybKVxUU95/BdW79T6ygmd25CbHSITgqs8waUkSxh9gdpsK7gWqC
        zA2JtVXh+N4iSFMce3LjXD5zdsvVdIO6FFgGQqqn0/eUYoFC6Wzbnt/eWMpWuU7ORctE50
        QdFgl4c1DMjPoMUsmgGoxGaFC9yMFIXr4MhrJQCJydtSzP4SYKneCBjYuyTZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1654016454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=L8tIRiYdKR8dkInFL+mBDdM1pWuIUReLUu5JEdcTNZw=;
        b=mhA7DFOiSviphsLOUCO/Wewevj14cHOIvH40fnTjq3oM9Lg0r52sPlgm2/tVptbtYtDmxJ
        pw9yClpoZaf4zjRGiCR13R7+w1m8n4go0hvZKvc3/mNKgGIW9SnD5+XLDeVtXUYBvnIFCv
        ABlAKFv8qB71qrmqheHKAViiT5IejQl501ZaWtQ179uIosBfn8wVUdxETSSWx4poIAMA15
        sK22tGWNVt8qChCkEP6wJbO3UT6KAcYEko3LlhYVZ4E11vy7t7+G0Oem+d7jCsPx2uWqf7
        dbb9yj2hw6XYynaiNcObw+QoUJsIxzxLPgQrPMzRl3IwCuylOOJIM0Y5cqweWg==
ARC-Authentication-Results: i=1;
        rspamd-77f9f854d9-ttcbd;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Little-Obese: 0f30987b704e9737_1654016455114_2615898830
X-MC-Loop-Signature: 1654016455114:3157736382
X-MC-Ingress-Time: 1654016455114
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.96.96.15 (trex/6.7.1);
        Tue, 31 May 2022 17:00:55 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LCJSj2l7Pz2q;
        Tue, 31 May 2022 10:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1654016454;
        bh=L8tIRiYdKR8dkInFL+mBDdM1pWuIUReLUu5JEdcTNZw=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Y1Uqo+d0AROmuT9BeMcf/BMccawNRMsb7krIHUBLMq36SszQcMjlZ3z6ZyAcZc6cw
         FwJ66iR8mSIr4hTMGUFY164/1jdGouF1etAdov0+iuSKrttsgVTmRqW+g0/0hpoqbv
         dK5XFf1t4zaSUo/8OID7JDCwVu9IOr5vqpYLe33LUO6QKp0UdJX/KrAe9oXxK+79fr
         /tMWTIKOcEiAxRaN8PinqDbEOeoP4qaIQ40d2AHu+dA/ZJOMrIKTnMJsBkhOYqGqiJ
         661qAwZCqyUV8frALYyjHf206SX0QaKF//rOC8tU6KR1kRZaBB+fdbMa0PKvaDTgk/
         t8iFGO68c8Bfw==
Date:   Tue, 31 May 2022 10:00:50 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "ira.weiny@intel.com" <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben@bwidawsk.net>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        a.manzanares@samsung.com
Subject: Re: [PATCH v9 2/9] PCI: Replace magic constant for PCI Sig Vendor ID
Message-ID: <20220531170050.ue6hizqjugz2g4wl@offworld>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
 <20220531152632.1397976-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220531152632.1397976-3-ira.weiny@intel.com>
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

On Tue, 31 May 2022, ira.weiny@intel.com wrote:

>From: Ira Weiny <ira.weiny@intel.com>
>
>Replace the magic value in pci_bus_crs_vendor_id() with
>PCI_VENDOR_ID_PCI_SIG.
>
>Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
>Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>---
>Changes from V6
>	Simplify commit message
>---
> drivers/pci/probe.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>index 17a969942d37..6280e780a48c 100644
>--- a/drivers/pci/probe.c
>+++ b/drivers/pci/probe.c
>@@ -2312,7 +2312,7 @@ EXPORT_SYMBOL(pci_alloc_dev);
>
> static bool pci_bus_crs_vendor_id(u32 l)
> {
>-	return (l & 0xffff) == 0x0001;
>+	return (l & 0xffff) == PCI_VENDOR_ID_PCI_SIG;
> }
>
> static bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l,
>
>-- 
>2.35.1
>
