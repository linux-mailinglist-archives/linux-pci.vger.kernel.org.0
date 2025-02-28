Return-Path: <linux-pci+bounces-22644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3B1A49D2A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 16:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A40188EE2B
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 15:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A77827FE99;
	Fri, 28 Feb 2025 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B2N2dgOK"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D79276053;
	Fri, 28 Feb 2025 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755874; cv=none; b=hpuJ6YpYZJlxzpBa5PDSkXBlsAGv3cpDZZ2f0BX0x5XWYOXFkbEOALvCK31Qbn46a+AtVZGSAhiXKgS31LcL2PSHL+cdVAgqb2hU9FXEcHaoKauUEOdRyxpnlZmtBmOBiIwDcgeqnxtN/M1iSdgd9uyMWm3R+gX+/tFaM/eMNnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755874; c=relaxed/simple;
	bh=WPiUtcc+3Sz9TyjKgkcNcHzdNvarF61z9AUAee6Io3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Al7aL4Vjik5CL9d8/KNr4F7EpObQAWdO+V273C5IgyoimgLsXA9f8Xv2d9d39wG3d1iMAvxsmwuE0Ye4GkfeLjQ+q44QHSmwLpIi4SqVaStOxQPRHFnDt6zl2+6G1CHmDTfuVUy8HXA1I3f3gYrfIGARg11oSiNDBjtC9+BTGFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B2N2dgOK; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=ke9plzHJpbxXmh429WRCDIs7VEMNLqn0BCmKB+edWVg=;
	b=B2N2dgOK9ZeuzBXD/SpImrA9OBFty97QaswiJMkqJy4I6B3zdqD3q+WqwP3lXJ
	yavAleJEbZswyBX2qWuckXQPlpzCeOtzrW8B7o+65X6VYPp2J/uqJjgPDi2QIflg
	ter997rcE9B//v1n9WvFThUA8c3gy5y/TAf4vQux6Ba74=
Received: from [192.168.71.45] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDXfzRt08FncMCRPQ--.4226S2;
	Fri, 28 Feb 2025 23:17:02 +0800 (CST)
Message-ID: <86d23e69-e6e5-476b-9582-28352852ea94@163.com>
Date: Fri, 28 Feb 2025 23:17:01 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] genirq/msi: Add the address and data that show MSI/MSIX
To: Thomas Gleixner <tglx@linutronix.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kw@linux.com, kwilczynski@kernel.org, bhelgaas@google.com,
 cassel@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227162821.253020-1-18255117159@163.com>
 <20250227163937.wv4hsucatyandde3@thinkpad> <877c5be0no.ffs@tglx>
 <251ce5c0-8c10-4b29-9ffb-592e908187fd@163.com> <874j0ee2ds.ffs@tglx>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <874j0ee2ds.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDXfzRt08FncMCRPQ--.4226S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXry5uF1UurykZF4DGF4DJwb_yoWrCFy3pF
	y5KF47Gr4xJF1jqw4xWa1DX34Yva4qy3WUt3srtr1fArWkX34kKFyIgFW29FyYyr10qr1j
	y3WUXasYqrW5AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U9eOJUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxECo2fBxZJ8AQABsy



On 2025/2/28 19:26, Thomas Gleixner wrote:
> On Fri, Feb 28 2025 at 17:04, Hans Zhang wrote:
>> Is the following patch OK?
> 
> No.
> 
>>    static void
>>    irq_debug_show_chip(struct seq_file *m, struct irq_data *data, int ind)
>>    {
>> @@ -178,6 +199,7 @@ static int irq_debug_show(struct seq_file *m, void *p)
>>           seq_printf(m, "node:     %d\n", irq_data_get_node(data));
>>           irq_debug_show_masks(m, desc);
>>           irq_debug_show_data(m, data, 0);
>> +       irq_debug_show_msi_msix(m, data, 0);
>>           raw_spin_unlock_irq(&desc->lock);
>>           return 0;
>>    }
> 
> This is just violating the layering and I told you what to do:
> 
>      "implement a debug_show() callback in the MSI core code and assign
>       it to domain ops::debug_show() on domain creation, if it does not
>       provide its own callback."
> 
> If you don't understand what I tell you, then please ask instead of
> going off and hacking up something completely different.
> 
> Here is another hint:
> 
>       Look at msi_domain_ops_default and at msi_domain_update_dom_ops()
> 
> If you still have questions, feel free to ask.
> 


Hi Thomas(tglx),

I'm very sorry that I didn't understand what you meant at the beginning. 
Thank you very much for your patient guidance.

Now, how about this patch? If you agree, I will resubmit the next version.

Best regards
Hans


patch:

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 396a067a8a56..98771a0b7d70 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -756,12 +756,33 @@ static int msi_domain_translate(struct irq_domain 
*domain, struct irq_fwspec *fw
         return info->ops->msi_translate(domain, fwspec, hwirq, type);
  }

+static void msi_domain_debug_show(struct seq_file *m, struct irq_domain *d,
+                                 struct irq_data *irqd, int ind)
+{
+       struct msi_desc *desc;
+       bool is_msix;
+
+       desc = irq_get_msi_desc(irqd->irq);
+       if (!desc)
+               return;
+
+       is_msix = desc->pci.msi_attrib.is_msix;
+       seq_printf(m, "%*s%s:", ind, "", is_msix ? "msix" : "msi");
+       seq_printf(m, "\n%*saddress_hi: 0x%08x", ind + 1, "",
+                  desc->msg.address_hi);
+       seq_printf(m, "\n%*saddress_lo: 0x%08x", ind + 1, "",
+                  desc->msg.address_lo);
+       seq_printf(m, "\n%*smsg_data:   0x%08x\n", ind + 1, "",
+                  desc->msg.data);
+}
+
  static const struct irq_domain_ops msi_domain_ops = {
         .alloc          = msi_domain_alloc,
         .free           = msi_domain_free,
         .activate       = msi_domain_activate,
         .deactivate     = msi_domain_deactivate,
         .translate      = msi_domain_translate,
+       .debug_show     = msi_domain_debug_show,
  };

  static irq_hw_number_t msi_domain_ops_get_hwirq(struct msi_domain_info 
*info,



e.g.

root@root:/sys/kernel/debug/irq/irqs# cat /proc/interrupts | grep ITS
  85:          0          0          0          0          0          0 
         0          0          0          0          0          0 
ITS-MSI 75497472 Edge      PCIe PME, aerdrv
  86:          0         30          0          0          0          0 
         0          0          0          0          0          0 
ITS-MSI 76021760 Edge      nvme0q0
  87:        287          0          0          0          0          0 
         0          0          0          0          0          0 
ITS-MSI 76021761 Edge      nvme0q1
  88:          0        265          0          0          0          0 
         0          0          0          0          0          0 
ITS-MSI 76021762 Edge      nvme0q2
  89:          0          0        177          0          0          0 
         0          0          0          0          0          0 
ITS-MSI 76021763 Edge      nvme0q3
  90:          0          0          0         76          0          0 
         0          0          0          0          0          0 
ITS-MSI 76021764 Edge      nvme0q4
  91:          0          0          0          0        161          0 
         0          0          0          0          0          0 
ITS-MSI 76021765 Edge      nvme0q5
  92:          0          0          0          0          0        991 
         0          0          0          0          0          0 
ITS-MSI 76021766 Edge      nvme0q6
  93:          0          0          0          0          0          0 
       194          0          0          0          0          0 
ITS-MSI 76021767 Edge      nvme0q7
  94:          0          0          0          0          0          0 
         0         94          0          0          0          0 
ITS-MSI 76021768 Edge      nvme0q8
  95:          0          0          0          0          0          0 
         0          0        148          0          0          0 
ITS-MSI 76021769 Edge      nvme0q9
  96:          0          0          0          0          0          0 
         0          0          0        261          0          0 
ITS-MSI 76021770 Edge      nvme0q10
  97:          0          0          0          0          0          0 
         0          0          0          0        127          0 
ITS-MSI 76021771 Edge      nvme0q11
  98:          0          0          0          0          0          0 
         0          0          0          0          0        317 
ITS-MSI 76021772 Edge      nvme0q12
root@root:/sys/kernel/debug/irq/irqs#
root@root:/sys/kernel/debug/irq/irqs# cat 87
handler:  handle_fasteoi_irq
device:   0000:91:00.0
status:   0x00000000
istate:   0x00004000
ddepth:   0
wdepth:   0
dstate:   0x31600200
             IRQD_ACTIVATED
             IRQD_IRQ_STARTED
             IRQD_SINGLE_TARGET
             IRQD_AFFINITY_MANAGED
             IRQD_AFFINITY_ON_ACTIVATE
             IRQD_HANDLE_ENFORCE_IRQCTX
node:     0
affinity: 0
effectiv: 0
domain:  :soc@0:interrupt-controller@0e001000:its@0e050000-3
  hwirq:   0x4880001
  chip:    ITS-MSI
   flags:   0x20
              IRQCHIP_ONESHOT_SAFE
  msix:
   address_hi: 0x00000000
   address_lo: 0x0e060040
   msg_data:   0x00000001
  parent:
     domain:  :soc@0:interrupt-controller@0e001000:its@0e050000-5
      hwirq:   0x2002
      chip:    ITS
       flags:   0x0
      parent:
         domain:  :soc@0:interrupt-controller@0e001000-1
          hwirq:   0x2002
          chip:    GICv3
           flags:   0x15
                      IRQCHIP_SET_TYPE_MASKED
                      IRQCHIP_MASK_ON_SUSPEND
                      IRQCHIP_SKIP_SET_WAKE






