Return-Path: <linux-pci+bounces-10492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 522FD9348CE
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 09:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF691F225F9
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 07:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0999A48CCC;
	Thu, 18 Jul 2024 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6LIto5D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D411F18059;
	Thu, 18 Jul 2024 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287829; cv=none; b=LLwpNv7sMYmbr6eznFhqE6zOQGxzhRUUWBAf/lZvP8RDUNGQirYQ/6JGyci4l/MgGfZAyEMgdNPQUp2vUVsdBy9cCpbgMl/KzcHphGIUCzwcqa4FB2fKsm6yEQQDnUDEwVMOfzNeQ5I2JrIPfCL1uCqa7v7y/4DRC7tdMGvMZX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287829; c=relaxed/simple;
	bh=tKHZd92Ldprva8w2gVqxxZu+Vxl7xygzISLGaCk8seo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPxnz6nXNKTqPGsorn6/zeZ/SoU4kPu3DH8/+w9yNsi8pSwG+MZjo7kyq+8AzBPlKtfhmKwtW9aok+1si07/Wb3OyMPxxs2cahpKJMXZi/ZKAz9i6gI9Qw/6Uo55s1U4b9mdFKKxAqRLPsVinJ+PMt3W0mbCeb9vRTy5wf802+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6LIto5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553B3C116B1;
	Thu, 18 Jul 2024 07:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721287829;
	bh=tKHZd92Ldprva8w2gVqxxZu+Vxl7xygzISLGaCk8seo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J6LIto5DkYvd+S6fo+qYv5RTOsq7oMu32/gg+8l/asxogKsN8VtVmkrb2SZlalO5w
	 vVmZPxiY13rjyrKlOQYRGN5GBBcq1OosQ7jGrxPWdtcWZNYTwwSxPkZeQ8X2xsAlEz
	 rA8tBIoi0fIQZdbXyjQpklUtWTqaZOjLQ8X0h2xddS1HYHdvEVTd0OAS20MRDpKKfM
	 StdkOeqhH7Ee3/50obTditILbTcbctfYM2jXzHmP8tvMZnj3FPOgQtnvzh6yHT/SZZ
	 GsCfSpIGMh7WxaCMPh0PG8vkUMSD4iVCVjMT+Q4tkZoQv2NDPw+lNA8r45SoKSOKRd
	 orOzTpqgb8d1A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sULay-000000004EA-0Y87;
	Thu, 18 Jul 2024 09:30:32 +0200
Date: Thu, 18 Jul 2024 09:30:32 +0200
From: Johan Hovold <johan@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	anna-maria@linutronix.de, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com,
	rdunlap@infradead.org, vidyas@nvidia.com,
	ilpo.jarvinen@linux.intel.com, apatel@ventanamicro.com,
	kevin.tian@intel.com, nipun.gupta@amd.com, den@valinux.co.jp,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org,
	rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org,
	lorenzo.pieralisi@arm.com, jgg@mellanox.com,
	ammarfaizi2@gnuweeb.org, robin.murphy@arm.com,
	lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org,
	vkoul@kernel.org, okaya@kernel.org, agross@kernel.org,
	andersson@kernel.org, mark.rutland@arm.com,
	shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com
Subject: Re: [patch V4 00/21] genirq, irqchip: Convert ARM MSI handling to
 per device MSI domains
Message-ID: <ZpjEmNbDvm7WTUKr@hovoldconsulting.com>
References: <ZpUFl4uMCT8YwkUE@hovoldconsulting.com>
 <878qy26cd6.wl-maz@kernel.org>
 <ZpUtuS65AQTJ0kPO@hovoldconsulting.com>
 <86r0bt39zm.wl-maz@kernel.org>
 <ZpaJaM1G721FdLFn@hovoldconsulting.com>
 <86plrd2o5o.wl-maz@kernel.org>
 <Zpdxe4ce-XwDEods@hovoldconsulting.com>
 <86msmg2n73.wl-maz@kernel.org>
 <ZpfJc80IInRLbRs5@hovoldconsulting.com>
 <86jzhj3hlx.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86jzhj3hlx.wl-maz@kernel.org>

On Wed, Jul 17, 2024 at 09:10:02PM +0100, Marc Zyngier wrote:

> I think I've finally nailed the sucker, and posted a potential fix[1].
> 
> It definitely restore my TX1 to a state that is no worse than normal,
> so something must be less wrong there.  I'm pretty sure that the
> platform-msi equivalent is equally broken, but I don't have the energy
> to verify/debug that tonight.

> [1] https://lore.kernel.org/r/20240717195937.2240400-1-maz@kernel.org

This seems to fix the regression here too, thanks!

201:          0       ...         0  ITS-PCI-MSI-0006:00:00.0   0 Edge      PCIe PME, aerdrv
202:          0                   0  ITS-PCI-MSI-0006:01:00.0   0 Edge      bhi
203:          0                   0  ITS-PCI-MSI-0006:01:00.0   1 Edge      mhi
204:          0                   0  ITS-PCI-MSI-0006:01:00.0   2 Edge      mhi
205:          0                   0  ITS-PCI-MSI-0006:01:00.0   3 Edge      ce0
206:          0                   0  ITS-PCI-MSI-0006:01:00.0   4 Edge      ce1
207:          0                   0  ITS-PCI-MSI-0006:01:00.0   5 Edge      ce2
208:          0                   2  ITS-PCI-MSI-0006:01:00.0   6 Edge      ce3
209:          2                   0  ITS-PCI-MSI-0006:01:00.0   7 Edge      ce5
210:          0                   0  ITS-PCI-MSI-0006:01:00.0   8 Edge      ce7
211:          0                   0  ITS-PCI-MSI-0006:01:00.0   9 Edge      ce8
216:          0                   0  ITS-PCI-MSI-0006:01:00.0  14 Edge      DP_EXT_IRQ
217:          0                   0  ITS-PCI-MSI-0006:01:00.0  15 Edge      DP_EXT_IRQ
218:          0                   0  ITS-PCI-MSI-0006:01:00.0  16 Edge      DP_EXT_IRQ
220:          0                   0  ITS-PCI-MSI-0006:01:00.0  18 Edge      DP_EXT_IRQ
221:          0                   0  ITS-PCI-MSI-0006:01:00.0  19 Edge      DP_EXT_IRQ
222:          0                   0  ITS-PCI-MSI-0006:01:00.0  20 Edge      DP_EXT_IRQ
223:          0                   0  ITS-PCI-MSI-0006:01:00.0  21 Edge      DP_EXT_IRQ
224:          0                   0  ITS-PCI-MSI-0006:01:00.0  22 Edge      DP_EXT_IRQ
225:          0                   0  ITS-PCI-MSI-0006:01:00.0  23 Edge      DP_EXT_IRQ
226:          0                   0  ITS-PCI-MSI-0006:01:00.0  24 Edge      DP_EXT_IRQ
235:          0                   0  ITS-PCI-MSI-0004:00:00.0   0 Edge      PCIe PME, aerdrv
236:          0                   0  ITS-PCI-MSI-0004:01:00.0   0 Edge      bhi
237:          0                   0  ITS-PCI-MSI-0004:01:00.0   1 Edge      mhi
238:          0                   0  ITS-PCI-MSI-0004:01:00.0   2 Edge      mhi
239:          0                   0  ITS-PCI-MSI-0004:01:00.0   3 Edge      mhi
240:          0                   0  ITS-PCI-MSI-0004:01:00.0   4 Edge      mhi
242:          0                   0  ITS-PCI-MSI-0002:00:00.0   0 Edge      PCIe PME, aerdrv
243:         22                   0  ITS-PCI-MSIX-0002:01:00.0   0 Edge      nvme0q0
244:          0                   0  ITS-PCI-MSIX-0002:01:00.0   1 Edge      nvme0q1
245:          0                   0  ITS-PCI-MSIX-0002:01:00.0   2 Edge      nvme0q2
246:          0                   0  ITS-PCI-MSIX-0002:01:00.0   3 Edge      nvme0q3
247:          0                   0  ITS-PCI-MSIX-0002:01:00.0   4 Edge      nvme0q4
248:          0                   0  ITS-PCI-MSIX-0002:01:00.0   5 Edge      nvme0q5
249:          0                   0  ITS-PCI-MSIX-0002:01:00.0   6 Edge      nvme0q6
250:          0                   0  ITS-PCI-MSIX-0002:01:00.0   7 Edge      nvme0q7
251:          0                   0  ITS-PCI-MSIX-0002:01:00.0   8 Edge      nvme0q8

Johan

