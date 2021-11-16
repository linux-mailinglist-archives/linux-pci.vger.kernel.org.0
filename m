Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAEA453B0E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 21:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhKPUlj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 15:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhKPUlj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Nov 2021 15:41:39 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BB5C061766;
        Tue, 16 Nov 2021 12:38:42 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so491623pjb.1;
        Tue, 16 Nov 2021 12:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L1Aa3agJEgHTydGbJ+CTp880pElw48GNNKQ4ED3u2vI=;
        b=VN9XYnxshvs2MoeSJpe+I4y+qT5APEDxU9p7gPKydcBpmlAMWrSagQ6KtJ6XJug2rC
         xrRDOnk7ctZLJowVIdDBQmQTYJEHY+VMvRkwT80fkUW84oxKYrzgDGx6vv9Kc7cXYma2
         b5qI0zRYKDA35SMBGd8vm8IU1PfQFB0wcuLEBg7DUCalJfEKWBvwkRt6HvmR9C8eWzF5
         WQXabB5j4+AhGz7ODVL5hgydZ4ndx7GT6Vp/l3dldBEW/CHxtSTnJmjUGGWCjXk415MG
         4pzvgG8O0OGJ2AizOAF39o2p6a927CCRZVypu04Mi1ZtDwvIbIlx6wsGQT52RlkZprqY
         xhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L1Aa3agJEgHTydGbJ+CTp880pElw48GNNKQ4ED3u2vI=;
        b=HyGIzLV65UweX3gXf8+lQaiFZ/QL7teBSJcuiQUlf9Cm0MiSjdhTzYbOMsB1Rk5waU
         j+46JfmgX7e0sKpAsvdaJSjCclSfkq4dV5fXELSXmhdrztJkj/CAEAh28YszNa3CU96h
         l9VrPcMApOQP738/618yzpp0G3Oe1TAo3JgKHV2m8iuOvS5G1aa6Ytx1/5PD8dXyJGX2
         e9W2KZckvXRLuVzjxsphXLH8FZkNd4ErI+cjaflOEwkzTPBQ5CcWKAEBLuPU+C7Fm6FZ
         lEFdKmwoRvBI/oPNssIfLLEAcZL7ckxdLNhxtGoRkyXiZpdRpsjMp6jgk+i9tD8C7qAj
         X8dQ==
X-Gm-Message-State: AOAM5310v0HsSxVnQ7oV2PDUTXkWHW2CY6dZVQiEkgxk1tvSCzU/EA2e
        zXxBMeCOiesiGQrX0UTcsVA=
X-Google-Smtp-Source: ABdhPJwtlgGBSK5f9oPOiX8vOtjsppRXs9k2VBvEVSVxBR15HeKTJEG1e0r+PYA+ADSPSFiU3kHlXQ==
X-Received: by 2002:a17:90b:4b04:: with SMTP id lx4mr2312775pjb.11.1637095121660;
        Tue, 16 Nov 2021 12:38:41 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9sm2729185pjs.2.2021.11.16.12.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 12:38:41 -0800 (PST)
Subject: Re: [PATCH v2 1/1] PCI: brcmstb: Use BIT() as __GENMASK() is for
 internal use only
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20211115112000.23693-1-andriy.shevchenko@linux.intel.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <41b85802-6118-33a6-692a-043d74b82d8e@gmail.com>
Date:   Tue, 16 Nov 2021 12:38:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211115112000.23693-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/15/21 3:20 AM, Andy Shevchenko wrote:
> Use BIT() as __GENMASK() is for internal use only. The rationale
> of switching to BIT() is to provide better generated code. The
> GENMASK() against non-constant numbers may produce an ugly assembler
> code. On contrary the BIT() is simply converted to corresponding shift
> operation.

The code is not necessarily any different on ARMv8 as far as I can tell,
before:

static void brcm_msi_set_regs(struct brcm_msi *msi)
{
        u32 val = __GENMASK(31, msi->legacy_shift);
      84:       b9406402        ldr     w2, [x0,#100]
      88:       d2800021        mov     x1, #0x1
// #1
      8c:       9ac22021        lsl     x1, x1, x2
      90:       4b0103e1        neg     w1, w1


after:

static void brcm_msi_set_regs(struct brcm_msi *msi)
{
        u32 val = ~(BIT(msi->legacy_shift) - 1);
      84:       b9406402        ldr     w2, [x0,#100]
      88:       d2800021        mov     x1, #0x1
// #1
      8c:       9ac22021        lsl     x1, x1, x2
      90:       4b0103e1        neg     w1, w1

and the usage of BIT() does not make this any clearer.

How about this instead:

diff --git a/drivers/pci/controller/pcie-brcmstb.c
b/drivers/pci/controller/pcie-brcmstb.c
index 1fc7bd49a7ad..f832c07337fa 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -144,6 +144,8 @@
 #define BRCM_INT_PCI_MSI_NR            32
 #define BRCM_INT_PCI_MSI_LEGACY_NR     8
 #define BRCM_INT_PCI_MSI_SHIFT         0
+#define BRCM_INT_PCI_MSI_MASK          GENMASK(BRCM_INT_PCI_MSI_NR - 1, 0)
+#define BRCM_INT_PCI_MSI_LEGACY_MASK   GENMASK(31, 32 -
BRCM_INT_PCI_MSI_LEGACY_NR)

 /* MSI target addresses */
 #define BRCM_MSI_TARGET_ADDR_LT_4GB    0x0fffffffcULL
@@ -619,7 +621,8 @@ static void brcm_msi_remove(struct brcm_pcie *pcie)

 static void brcm_msi_set_regs(struct brcm_msi *msi)
 {
-       u32 val = __GENMASK(31, msi->legacy_shift);
+       u32 val = msi->legacy ? BRCM_INT_PCI_MSI_MASK :
+                               BRCM_INT_PCI_MSI_LEGACY_MASK;

        writel(val, msi->intr_base + MSI_INT_MASK_CLR);
        writel(val, msi->intr_base + MSI_INT_CLR);


> 
> Note, it's the only user of __GENMASK() in the kernel outside of its own realm.
> 
> Fixes: 3baec684a531 ("PCI: brcmstb: Accommodate MSI for older chips")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: switched to BIT() and elaborated why, hence not included tag
>  drivers/pci/controller/pcie-brcmstb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 1fc7bd49a7ad..0c49fc65792c 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -619,7 +619,7 @@ static void brcm_msi_remove(struct brcm_pcie *pcie)
>  
>  static void brcm_msi_set_regs(struct brcm_msi *msi)
>  {
> -	u32 val = __GENMASK(31, msi->legacy_shift);
> +	u32 val = ~(BIT(msi->legacy_shift) - 1);
>  
>  	writel(val, msi->intr_base + MSI_INT_MASK_CLR);
>  	writel(val, msi->intr_base + MSI_INT_CLR);
> 


-- 
Florian
