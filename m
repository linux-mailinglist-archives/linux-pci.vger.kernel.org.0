Return-Path: <linux-pci+bounces-22622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7759FA4945F
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 10:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DDC18874AE
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 09:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745FB1BE23E;
	Fri, 28 Feb 2025 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ikfT6RAO"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1B11A3158;
	Fri, 28 Feb 2025 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740733525; cv=none; b=ukvKgahgyMpCCrtovBoN0/vedY4RyUpJunjtYaRYsK3ozVAUlU5p/w/ka+S0qknpEUeEH2+s0WLBZYpvLVFX6Y+NCEpoRKLhP3u5/TWryPfcIQlubOgM5m70O3RsPIynSJ1xizEMiRCtu2zyns3L/PcHmS8ZPnC+Ndju1I8m6gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740733525; c=relaxed/simple;
	bh=ZvuoGKETIKuqrexGW8SWwG8bQ1czS38AO8zWebfhBU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXGW4XOU8CZ6BefPOwwmMyp4UgjGw2w+Tbzr7UkjEVi9Ccyu3Jt7GaWdMiW5Ov5PHEc6Hq8I4TJnGBQJgGjjViGIrSnsDoeY6P4AFzOidFjOLiUnCfwJeomC5LmVLnLOXV0craNhghLqmWHr0s2wRCIYBQyFvz7MW7Qoub+DW2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ikfT6RAO; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=nNdk8J4H0DGZo/AJqzuSIUDj2qvadjIR23mnD0+nTyw=;
	b=ikfT6RAOEWarYrABl77wrDMFDpkaDJiqeOmRk5vjn8ujOspOjpkgiJzEywroGb
	/bVKQMoAbo3OEBsaQbNXUUhOaJRMzPhy+LZtLpWTD2jiW7cvbHZoQlS44gppdc8Z
	bfw4JKwsrOIbxCTSz6j6XQDuPcoMDTNEMHMBhulKkMrNY=
Received: from [192.168.34.52] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDnMPYpfMFnEqAaJQ--.1908S2;
	Fri, 28 Feb 2025 17:04:43 +0800 (CST)
Message-ID: <251ce5c0-8c10-4b29-9ffb-592e908187fd@163.com>
Date: Fri, 28 Feb 2025 17:04:41 +0800
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
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <877c5be0no.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PSgvCgDnMPYpfMFnEqAaJQ--.1908S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GryfAFyUAr18Jr4UKF43trb_yoWxCF18pF
	yUKF47Cr48JFyYywsrGa17ur9rXFWqvF4qy39Fy3yIy3yaqw1vgFyfZas7GFy5trsrZ3s5
	t3WUXa40qrs3AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Um2NNUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDx4Co2fBdUDKGQAAsw



On 2025/2/28 01:51, Thomas Gleixner wrote:
> On Thu, Feb 27 2025 at 22:09, Manivannan Sadhasivam wrote:
>> On Fri, Feb 28, 2025 at 12:28:21AM +0800, Hans Zhang wrote:
>>> +	return sysfs_emit(
>>> +		buf,
>>> +		"%s\n address_hi: 0x%08x\n address_lo: 0x%08x\n msg_data: 0x%08x\n",
>>> +		is_msix ? "msix" : "msi", desc->msg.address_hi,
>>> +		desc->msg.address_lo, desc->msg.data);
>>
>> Sysfs is an ABI. You cannot change the semantics of an attribute.
> 
> Correct. Aside of that this is debug information and has no business in
> sysfs.
> 
> The obvious place to expose this is via the existing debugfs irq/*
> mechanism. All it requires is to implement a debug_show() callback in
> the MSI core code and assign it to domain ops::debug_show() on domain
> creation, if it does not provide its own callback.

Hi Thomas(tglx),

Is the following patch OK? Please give me some advice. Thank you very much.

Best regards
Hans


patch:

diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index ca142b9a4db3..447fa24520f4 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -3,6 +3,7 @@

  #include <linux/irqdomain.h>
  #include <linux/irq.h>
+#include <linux/msi.h>
  #include <linux/uaccess.h>

  #include "internals.h"
@@ -56,6 +57,26 @@ static const struct irq_bit_descr irqchip_flags[] = {
         BIT_MASK_DESCR(IRQCHIP_MOVE_DEFERRED),
  };

+static void irq_debug_show_msi_msix(struct seq_file *m, struct irq_data 
*data,
+                                   int ind)
+{
+       struct msi_desc *desc;
+       bool is_msix;
+
+       desc = irq_get_msi_desc(data->irq);
+       if (!desc)
+               return;
+
+       is_msix = desc->pci.msi_attrib.is_msix;
+       seq_printf(m, "%*s%s:", ind, "", is_msix ? "msix" : "msi");
+       seq_printf(m, "\n%*saddress_hi: 0x%08x", ind + 1, "",
+               desc->msg.address_hi);
+       seq_printf(m, "\n%*saddress_lo: 0x%08x", ind + 1, "",
+               desc->msg.address_lo);
+       seq_printf(m, "\n%*smsg_data: 0x%08x\n", ind + 1, "",
+               desc->msg.data);
+}
+
  static void
  irq_debug_show_chip(struct seq_file *m, struct irq_data *data, int ind)
  {
@@ -178,6 +199,7 @@ static int irq_debug_show(struct seq_file *m, void *p)
         seq_printf(m, "node:     %d\n", irq_data_get_node(data));
         irq_debug_show_masks(m, desc);
         irq_debug_show_data(m, data, 0);
+       irq_debug_show_msi_msix(m, data, 0);
         raw_spin_unlock_irq(&desc->lock);
         return 0;
  }




e.g.
root@root:/sys/kernel/debug/irq/irqs# cat /proc/interrupts | grep ITS
  85:          0          0          0          0          0          0 
         0          0          0          0          0          0 
ITS-MSI 75497472 Edge      PCIe PME, aerdrv
  86:          0         30          0          0          0          0 
         0          0          0          0          0          0 
ITS-MSI 76021760 Edge      nvme0q0
  87:        682          0          0          0          0          0 
         0          0          0          0          0          0 
ITS-MSI 76021761 Edge      nvme0q1
  88:          0        400          0          0          0          0 
         0          0          0          0          0          0 
ITS-MSI 76021762 Edge      nvme0q2
  89:          0          0        246          0          0          0 
         0          0          0          0          0          0 
ITS-MSI 76021763 Edge      nvme0q3
  90:          0          0          0        141          0          0 
         0          0          0          0          0          0 
ITS-MSI 76021764 Edge      nvme0q4
  91:          0          0          0          0        177          0 
         0          0          0          0          0          0 
ITS-MSI 76021765 Edge      nvme0q5
  92:          0          0          0          0          0        173 
         0          0          0          0          0          0 
ITS-MSI 76021766 Edge      nvme0q6
  93:          0          0          0          0          0          0 
       374          0          0          0          0          0 
ITS-MSI 76021767 Edge      nvme0q7
  94:          0          0          0          0          0          0 
         0         62          0          0          0          0 
ITS-MSI 76021768 Edge      nvme0q8
  95:          0          0          0          0          0          0 
         0          0        137          0          0          0 
ITS-MSI 76021769 Edge      nvme0q9
  96:          0          0          0          0          0          0 
         0          0          0        177          0          0 
ITS-MSI 76021770 Edge      nvme0q10
  97:          0          0          0          0          0          0 
         0          0          0          0        403          0 
ITS-MSI 76021771 Edge      nvme0q11
  98:          0          0          0          0          0          0 
         0          0          0          0          0        246 
ITS-MSI 76021772 Edge      nvme0q12
root@root:/sys/kernel/debug/irq/irqs# cat 86
handler:  handle_fasteoi_irq
device:   0000:91:00.0
status:   0x00000000
istate:   0x00004000
ddepth:   0
wdepth:   0
dstate:   0x31401200
             IRQD_ACTIVATED
             IRQD_IRQ_STARTED
             IRQD_SINGLE_TARGET
             IRQD_AFFINITY_SET
             IRQD_AFFINITY_ON_ACTIVATE
             IRQD_HANDLE_ENFORCE_IRQCTX
node:     0
affinity: 6
effectiv: 6
domain:  :soc@0:interrupt-controller@0e001000:its@0e050000-3
  hwirq:   0x4880000
  chip:    ITS-MSI
   flags:   0x20
              IRQCHIP_ONESHOT_SAFE
  parent:
     domain:  :soc@0:interrupt-controller@0e001000:its@0e050000-5
      hwirq:   0x2001
      chip:    ITS
       flags:   0x0
      parent:
         domain:  :soc@0:interrupt-controller@0e001000-1
          hwirq:   0x2001
          chip:    GICv3
           flags:   0x15
                      IRQCHIP_SET_TYPE_MASKED
                      IRQCHIP_MASK_ON_SUSPEND
                      IRQCHIP_SKIP_SET_WAKE
msix:
  address_hi: 0x00000000
  address_lo: 0x0e060040
  msg_data: 0x00000000
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
msix:
  address_hi: 0x00000000
  address_lo: 0x0e060040
  msg_data: 0x00000001
root@root:/sys/kernel/debug/irq/irqs#
root@root:/sys/kernel/debug/irq/irqs# cat 88
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
affinity: 1
effectiv: 1
domain:  :soc@0:interrupt-controller@0e001000:its@0e050000-3
  hwirq:   0x4880002
  chip:    ITS-MSI
   flags:   0x20
              IRQCHIP_ONESHOT_SAFE
  parent:
     domain:  :soc@0:interrupt-controller@0e001000:its@0e050000-5
      hwirq:   0x2003
      chip:    ITS
       flags:   0x0
      parent:
         domain:  :soc@0:interrupt-controller@0e001000-1
          hwirq:   0x2003
          chip:    GICv3
           flags:   0x15
                      IRQCHIP_SET_TYPE_MASKED
                      IRQCHIP_MASK_ON_SUSPEND
                      IRQCHIP_SKIP_SET_WAKE
msix:
  address_hi: 0x00000000
  address_lo: 0x0e060040
  msg_data: 0x00000002
root@root:/sys/kernel/debug/irq/irqs# cat 89
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
affinity: 2
effectiv: 2
domain:  :soc@0:interrupt-controller@0e001000:its@0e050000-3
  hwirq:   0x4880003
  chip:    ITS-MSI
   flags:   0x20
              IRQCHIP_ONESHOT_SAFE
  parent:
     domain:  :soc@0:interrupt-controller@0e001000:its@0e050000-5
      hwirq:   0x2004
      chip:    ITS
       flags:   0x0
      parent:
         domain:  :soc@0:interrupt-controller@0e001000-1
          hwirq:   0x2004
          chip:    GICv3
           flags:   0x15
                      IRQCHIP_SET_TYPE_MASKED
                      IRQCHIP_MASK_ON_SUSPEND
                      IRQCHIP_SKIP_SET_WAKE
msix:
  address_hi: 0x00000000
  address_lo: 0x0e060040
  msg_data: 0x00000003




