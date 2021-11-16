Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97BD453B48
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 21:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhKPU7T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 15:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhKPU7T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Nov 2021 15:59:19 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29363C061570;
        Tue, 16 Nov 2021 12:56:22 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id t21so241586plr.6;
        Tue, 16 Nov 2021 12:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=39cKm0R+i4To7rY6Py1OreUinzGzFnAumMTH2oWu7uA=;
        b=RluKjMSfVNWNIY1ULO6cDI3US826rVfoKGl22NOHQA2ToaUxhdyohTbOzzvy769pq6
         WwzksFRe6ch+doZVdm7OOyzkFQbmkuQJQzC31OqD9Gvql6xkIBtPfbqlJfQO5YPuSTXU
         M5rpfxQjJfqbl5pp5/Esoz9kY/psNLjYWntCON2uf+KebdHWm3rf1/7spkb+vrAbuwzO
         j8l+RqqQ5Q1zqpfy+8zZRqwEYcNAMjs9/dxRmXXDkshD0zNGkhheavORAYVWGGedkkEQ
         YgmgaLzUDWxQANKOmSPgtykWzu7k+GbjmAcAedZKv4YkOMBQvVNZQLBfk26cKia34LVc
         PMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=39cKm0R+i4To7rY6Py1OreUinzGzFnAumMTH2oWu7uA=;
        b=4ZCGm8aHJhz+vHYopU4uKema8wOigjosQVKXMPCplofWNPsO3QtZDf6meeZOPkUfiq
         WECU8/K5X8xF0N8PE/fbJZC17/3XyxIcLDorQNRGXUv+7D5B4Y1fDNvHFO3dNCcom+Oe
         Spu0VbVBHTjaTy8XSToTsZK/Nghy20Zei3wE2k9gwoyzdTP1xO3Oi7DpDrBxLIfXq3KB
         flpMq56rlwAKNRx+vNA+DwOOCRSJz4vp8Ml2HYoRcb4zqRt9A+S3JA3yvXAfgzj+kDjK
         dUseD1NoVOhqwgEWYW+4L6By6EWcss+Y6JLNdSXjdWAEyH+k9j79X2esjVWTZRr0tuE0
         6b6Q==
X-Gm-Message-State: AOAM532FpcwzjiUTIx/utUmarNo8m0pobHD6x8fgWDqqJU0Wb8+Pww95
        84Iw2bdczU/xPun9RHXbB/c=
X-Google-Smtp-Source: ABdhPJx5KaXiM2+NxvzoCLM78szEDG3QOzTr3lVxWj+HCzTnO0onqeW1/kLTNXXIGldlhcoM346HjA==
X-Received: by 2002:a17:90a:9dca:: with SMTP id x10mr2648652pjv.170.1637096181623;
        Tue, 16 Nov 2021 12:56:21 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e14sm21030999pfv.18.2021.11.16.12.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 12:56:21 -0800 (PST)
Subject: Re: [PATCH v2 1/1] PCI: brcmstb: Use BIT() as __GENMASK() is for
 internal use only
To:     Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20211115112000.23693-1-andriy.shevchenko@linux.intel.com>
 <94d3f4e5-a698-134c-8264-55d31d3eafa6@arm.com>
 <CAHp75VeJ8ZiD=qQVfeahUjGZduFRJJ5683hn8f4810JYEzsCyw@mail.gmail.com>
 <YZJxG7JFAfIqr1/f@smile.fi.intel.com>
 <CAL_JsqJndi-gmenSpPtMVfsb3SrA=w+YBsSh3GigfgXC3rYDeQ@mail.gmail.com>
 <71a90592-99bb-13e1-a671-eb19c2dad3da@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <351fa3ec-52fa-58f5-cc57-e92498647d5c@gmail.com>
Date:   Tue, 16 Nov 2021 12:56:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <71a90592-99bb-13e1-a671-eb19c2dad3da@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/16/21 12:41 PM, Florian Fainelli wrote:
> On 11/16/21 10:20 AM, Rob Herring wrote:
>> +Marc Z
>>
>> On Mon, Nov 15, 2021 at 8:39 AM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>>
>>> On Mon, Nov 15, 2021 at 04:14:21PM +0200, Andy Shevchenko wrote:
>>>> On Mon, Nov 15, 2021 at 4:01 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>>>> On 2021-11-15 11:20, Andy Shevchenko wrote:
>>>>>> Use BIT() as __GENMASK() is for internal use only. The rationale
>>>>>> of switching to BIT() is to provide better generated code. The
>>>>>> GENMASK() against non-constant numbers may produce an ugly assembler
>>>>>> code. On contrary the BIT() is simply converted to corresponding shift
>>>>>> operation.
>>>>>
>>>>> FWIW, If you care about code quality and want the compiler to do the
>>>>> obvious thing, why not specify it as the obvious thing:
>>>>>
>>>>>         u32 val = ~0 << msi->legacy_shift;
>>>>
>>>> Obvious and buggy (from the C standard point of view)? :-)
>>>
>>> Forgot to mention that BIT() is also makes it easy to avoid such mistake.
>>>
>>>>> Personally I don't think that abusing BIT() in the context of setting
>>>>> multiple bits is any better than abusing __GENMASK()...
>>>>
>>>> No, BIT() is not abused here, but __GENMASK().
>>>>
>>>> After all it's up to you, folks, consider that as a bug report.
>>
>> Couldn't we get rid of legacy_shift entirely if the legacy case sets
>> up 'hwirq' as 24-31 rather than 0-7? Though the data for the MSI msg
>> uses the hwirq.
> 
> I personally find it clearer and easier to reason about with the current
> code though I suppose that with an appropriate xlate method we could
> sort of set up the hwirq the way we want them to be to avoid any
> shifting in brcm_pcie_msi_isr().

Something like the following maybe? Completely untested as I don't
believe I have a device with that legacy controller available at the moment:

diff --git a/drivers/pci/controller/pcie-brcmstb.c
b/drivers/pci/controller/pcie-brcmstb.c
index 1fc7bd49a7ad..41404b268fa3 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -144,6 +144,8 @@
 #define BRCM_INT_PCI_MSI_NR		32
 #define BRCM_INT_PCI_MSI_LEGACY_NR	8
 #define BRCM_INT_PCI_MSI_SHIFT		0
+#define BRCM_INT_PCI_MSI_MASK		GENMASK(BRCM_INT_PCI_MSI_NR - 1, 0)
+#define BRCM_INT_PCI_MSI_LEGACY_MASK	GENMASK(31, 32 -
BRCM_INT_PCI_MSI_LEGACY_NR)

 /* MSI target addresses */
 #define BRCM_MSI_TARGET_ADDR_LT_4GB	0x0fffffffcULL
@@ -269,8 +271,6 @@ struct brcm_msi {
 	/* used indicates which MSI interrupts have been alloc'd */
 	unsigned long		used;
 	bool			legacy;
-	/* Some chips have MSIs in bits [31..24] of a shared register. */
-	int			legacy_shift;
 	int			nr; /* No. of MSI available, depends on chip */
 	/* This is the base pointer for interrupt status/set/clr regs */
 	void __iomem		*intr_base;
@@ -486,7 +486,6 @@ static void brcm_pcie_msi_isr(struct irq_desc *desc)
 	dev = msi->dev;

 	status = readl(msi->intr_base + MSI_INT_STATUS);
-	status >>= msi->legacy_shift;

 	for_each_set_bit(bit, &status, msi->nr) {
 		int ret;
@@ -516,9 +515,8 @@ static int brcm_msi_set_affinity(struct irq_data
*irq_data,
 static void brcm_msi_ack_irq(struct irq_data *data)
 {
 	struct brcm_msi *msi = irq_data_get_irq_chip_data(data);
-	const int shift_amt = data->hwirq + msi->legacy_shift;

-	writel(1 << shift_amt, msi->intr_base + MSI_INT_CLR);
+	writel(BIT(data->hwirq), msi->intr_base + MSI_INT_CLR);
 }


@@ -573,9 +571,31 @@ static void brcm_irq_domain_free(struct irq_domain
*domain,
 	brcm_msi_free(msi, d->hwirq);
 }

+static int brcm_irq_domain_xlate(struct irq_domain *d,
+				 struct device_node *node,
+				 const u32 *intspec, unsigned int intsize,
+				 unsigned long *out_hwirq,
+				 unsigned int *out_type)
+{
+	struct brcm_msi *msi = d->host_data;
+
+	if (WARN_ON(intsize < 1))
+		return -EINVAL;
+
+	if (msi->legacy) {
+		*out_hwirq = intspec[0] + BRCM_INT_PCI_MSI_SHIFT;
+		*out_type = IRQ_TYPE_NONE;
+		return 0;
+	}
+
+	return irq_domain_xlate_onecell(d, node, intspec, intsize,
+					out_hwirq, out_type);
+}
+
 static const struct irq_domain_ops msi_domain_ops = {
 	.alloc	= brcm_irq_domain_alloc,
 	.free	= brcm_irq_domain_free,
+	.xlate	= brcm_irq_domain_xlate,
 };

 static int brcm_allocate_domains(struct brcm_msi *msi)
@@ -619,7 +639,8 @@ static void brcm_msi_remove(struct brcm_pcie *pcie)

 static void brcm_msi_set_regs(struct brcm_msi *msi)
 {
-	u32 val = __GENMASK(31, msi->legacy_shift);
+	u32 val = msi->legacy ? BRCM_INT_PCI_MSI_MASK :
+				BRCM_INT_PCI_MSI_LEGACY_MASK;

 	writel(val, msi->intr_base + MSI_INT_MASK_CLR);
 	writel(val, msi->intr_base + MSI_INT_CLR);
@@ -664,11 +685,9 @@ static int brcm_pcie_enable_msi(struct brcm_pcie *pcie)
 	if (msi->legacy) {
 		msi->intr_base = msi->base + PCIE_INTR2_CPU_BASE;
 		msi->nr = BRCM_INT_PCI_MSI_LEGACY_NR;
-		msi->legacy_shift = 24;
 	} else {
 		msi->intr_base = msi->base + PCIE_MSI_INTR2_BASE;
 		msi->nr = BRCM_INT_PCI_MSI_NR;
-		msi->legacy_shift = 0;
 	}

 	ret = brcm_allocate_domains(msi);

-- 
Florian
