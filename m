Return-Path: <linux-pci+bounces-40445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BE1C38F32
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 04:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1DD18C1CA1
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 03:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE75A2AE99;
	Thu,  6 Nov 2025 03:16:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FAB23EAA0
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 03:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762398993; cv=none; b=I1DuhtlbaWsN5B1kdGD8mIceqradEP17ZZU93ZUtjcyYJBEejvgwDJW1+6oz2QpvkRnulmepuZ+S45oYURNjG1UM6D1ttKpsscLju1qvIwnEEYRz/JaQi+lXD5+ZaKPuGnxQkhK1eTa/m+rf79tk8y+0BO0xTeMii76hR4Zbc9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762398993; c=relaxed/simple;
	bh=EmXFxS1n1/wO6jqPZbddjqlR06m+V1pVE8lhtcS+Luc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=MMo173Cc3xULPIu3gcEFauQc7dG7md1iAC3HFRUwDd2ByoeFP7S2Cz9ewOL+7+oPLJsXHW0p3Cs8kUoVEz3AvGlP6/VUiV6kBzujwgl5AmGp7fLCKtDrA/q0RbI3/slNSkYQNMCxwDDMe/OOGK4/vFGmXtZl4izYmx/JZi06d34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [IPV6:2400:2410:b120:f200:a1f3:73da:3a04:160d] (unknown [IPv6:2400:2410:b120:f200:a1f3:73da:3a04:160d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 6549C3F11A;
	Thu,  6 Nov 2025 04:16:27 +0100 (CET)
Message-ID: <c9594cc3-031b-43cc-9268-85c32f98ba49@hogyros.de>
Date: Thu, 6 Nov 2025 12:16:24 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: dri-devel@lists.freedesktop.org,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 linux-pci@vger.kernel.org
From: Simon Richter <Simon.Richter@hogyros.de>
Subject: Unreachable cards in vgaarb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have a card whose VGA registers are not actually reachable, for 
multiple reasons:

1. the system in question has multiple PCI domains
2. the system in question does not support IO access
3. one of the bridges involved does not support VGA register forwarding

Obviously, the "works for me" solution would be to teach vgaarb to check 
if the VGA bit actually got set in the bridge control register (because 
apparently, that is how a bridge indicates missing support), and return 
an error. I plan to do that, but that doesn't solve the others.

The specific actual problem I'm trying to solve here is that there is a 
workaround in the i915 and xe drivers that pokes the VGA register space 
on the same card after changing power states, and this falls over on my 
system. Skipping this is safe if we can guarantee that vgacon will not 
generate accesses later, so I think having vgaarb recognize that the 
card is unreachable and returning an error is sufficient here.

I have no idea whether this will break other systems though -- can we 
reasonably assume that any PCI or PCIe bridge that is capable of 
forwarding VGA accesses will proudly display the VGA bit set in the 
bridge control register, or is a quirk needed here?

For multiple PCI domains, I have no clue how to determine where accesses 
end up. My feeling is that it's supposed to be "all of them, mediated by 
VGA bits on root bridges", but I don't know if this is actually true. Is 
anyone actually building machines with a CPU architecture that has a 
separate IO range, and multiple PCI domains?

For "no IO access", it is even more complex -- it appears that the 
approach on POWER is to define inb/outb as MMIO, offset from a global 
variable that points at a PCI range, which means this access will only 
show up in one of the PCI(e) controllers.

What is unclear to me is

1. whether there is supposed to be a mechanism to generate IO accesses 
from those,
2. whether this range should be excluded from MMIO to not accidentally 
create conflicts
3. whether vgaarb needs to adjust this variable too
4. if this variable should instead be maintained by vgaarb
5. if we should have dedicated vga_inb/vga_outb macros or if we can 
assume that any inb/outb on machines that don't have an IO range will be 
VGA accesses anyway
6. whether it is interesting to create special handling for cards that 
have VGA registers at the beginning of their non-prefetchable MMIO range 
(AFAIK, some Intel cards do, and you can address them either via IO or 
via MMIO to their non-prefetchable mapping).
7. whether this affects more than two users.

    Simon

