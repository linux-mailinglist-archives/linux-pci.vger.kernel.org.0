Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE9F53953F
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 19:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346387AbiEaRHm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 13:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346436AbiEaRHl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 13:07:41 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F149C8DDCC;
        Tue, 31 May 2022 10:07:34 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0DFE66C1FA6;
        Tue, 31 May 2022 17:00:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0A8136C2114;
        Tue, 31 May 2022 17:00:16 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1654016416; a=rsa-sha256;
        cv=none;
        b=QX2ksRbCwwylwUewYYzBAn4DV+az79n5Rc9lTFVsaETiYMaq9qBuFcwTLz+ouF+jbYtBJ8
        bPeD0CoaU7fCDvQTA6us8lRyeV3Olet+GPxfMFSzlbNHG3uRWKnqN8WZIJ+vungxJxHv3M
        O8zn+lqyjTjHGqfwYvo8fI5UH6S6VosRbV8H9WkFp5MN8zWjSi0GeO0ZHox03hXuBQC4Qp
        VIEXZRYkTxHROea9SJpt/dNu+du9FWJWZExzbquW/tLtuV5pG+L+LcSIaocHfDhzjEj1/W
        kj33rWiYJSQziEt2o4XOnbTN664gVeUxamKZ1W1zzdRKuBjMyBjMw2SX5kcTGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1654016416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=xh6g3OnYgOARYnrm0HnNILhGZu8yEtDYkR54Gfjgl7k=;
        b=4XA4G6+Het4QS/uEmG2Hffy7DMrUxMqgmUM+6bNTM7moCCJcZ1VAuwy76mqxELGjkvlCci
        lXdYwWywsMhZv4EO6wDWlEjJ+/6um7/tUsw1VQCG1JK0hfsHe5+KWpt437SNAwRfaE3xsl
        urS0DFGX98Fusme77gHCrHeksbzODQR33ozW9QnWq9aWHNcaKEfDjbWFEIXH7A+u9PzfIu
        aj9m5WVaIR/92r0p9iBT+29/859hjm31RxZy0jHy854jiHVxHAahYrMDEarUq4lOwG/ou0
        rLu1/uM0DEIOSwSZRW2wRGpFaByBpl4ImAk3B+xWgNu4NSeF6Esz2mGIXJoVRQ==
ARC-Authentication-Results: i=1;
        rspamd-77f9f854d9-ttcbd;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Society-Skirt: 7e4acaf972c84e96_1654016416565_595515388
X-MC-Loop-Signature: 1654016416565:4149019227
X-MC-Ingress-Time: 1654016416565
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.105.211.140 (trex/6.7.1);
        Tue, 31 May 2022 17:00:16 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LCJRy34rRz3H;
        Tue, 31 May 2022 10:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1654016415;
        bh=xh6g3OnYgOARYnrm0HnNILhGZu8yEtDYkR54Gfjgl7k=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=F4lT6yesUDFDgcPAs9cdLLpTsFA5xC0blgAX71tJOj7IUjAmo8fkG98E556WoOYIb
         HWuEqcdGhxKWt3ShUP7m6e4XR4MkYgrx8q67klmn9xmtz6s9pdS8LjwgOgGDOBpTQn
         RWP4S9G9kzIO7MGchFKkzVC2ZsZdF5vaWcRizWnuwR7iJe+6/6CBk87zEIDbwYhBAB
         RypbhRdrbuZTxhROk30hABEI06ah8Oz70dAn5Sbi4kt4Iixlt8cBHCE2mzODbUUebS
         XjBQOARdTp4xx/0zhUWUdxVGk0D+oCCDzXcFCLJgiaLfj6dHU6nRAy5L8OIMxr7cJ7
         DrpNXkUy27bxw==
Date:   Tue, 31 May 2022 10:00:11 -0700
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
Subject: Re: [PATCH v9 1/9] PCI: Add vendor ID for the PCI SIG
Message-ID: <20220531170011.4rm654khkff66j2h@offworld>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
 <20220531152632.1397976-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220531152632.1397976-2-ira.weiny@intel.com>
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

>From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>This ID is used in DOE headers to identify protocols that are defined
>within the PCI Express Base Specification, PCIe r6.0, sec 6.30.1.1 table
>6-32.
>
>Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> include/linux/pci_ids.h | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>index 0178823ce8c2..8af3b86206b1 100644
>--- a/include/linux/pci_ids.h
>+++ b/include/linux/pci_ids.h
>@@ -151,6 +151,7 @@
> #define PCI_CLASS_OTHERS		0xff
>
> /* Vendors and devices.  Sort key: vendor first, device next. */
>+#define PCI_VENDOR_ID_PCI_SIG		0x0001
>
> #define PCI_VENDOR_ID_LOONGSON		0x0014
>
>
>-- 
>2.35.1
>
