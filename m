Return-Path: <linux-pci+bounces-32624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F82B0BE56
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 10:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3F43A37FF
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 08:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C836EEBA;
	Mon, 21 Jul 2025 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtwtjFla"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D13469D
	for <linux-pci@vger.kernel.org>; Mon, 21 Jul 2025 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084867; cv=none; b=PLnWU3HZBrWtS1vGIaltdy06TA8tvGqER5s0HhQG4jlPaqxZRaun9deAN78cVFJkR7WiIWIUgPjze9Z6HKNXavk4sb78m4vAMO1eoLC8ETmYOG2Jl+hXovy5GHTnTUIbA5f/QTz44ek6uS/a6lkDog+g/djrNbUHPiMslznzPZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084867; c=relaxed/simple;
	bh=UV4FxFcNw5fENRS7/A2haNkNzeYWsGbFUoh808XQnJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRDJ/2MjsAeHZZLN2v5Jf8jUHB7h1cHc/avyCIGeD/7eI6sJE5jqarCTXOp6RrbktUs97c7zbIkTc4+0bYUrxO5cQ08og4wLDJg+fIX1DRkCkWO62zH7YX7PY7xFITIOr7WwB9JZDOqTv36je2iqKWdE6NYCUX/Aa72ysLk6dCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtwtjFla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3568C4CEED;
	Mon, 21 Jul 2025 08:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753084867;
	bh=UV4FxFcNw5fENRS7/A2haNkNzeYWsGbFUoh808XQnJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QtwtjFlapuseR9YFt6kTyLB5LRODCJulWBn5bM8SWPC1i41M/YzRjpnpRA87NoOpH
	 C3fkllRAO+rFrdIsjxOzF/hOZyCNXWH+RRS5UXtvFa8Hu/drcDCWSA915P6hprZsK8
	 AYo7lH35piDUcWV2mHtTIZjDbG1yiKJVURHcp9DpW3cba20+G/SGX2PHenwvzIk7jq
	 hpkDdMXXrWIKuIwIiP834JjSR8MVyAm9UygCpFZk/8jB9inI4axRlwzEEuP5zntrXF
	 fdYz/IP1kJ5CI/AnjYjd137FOBYxktJ18V1vfiNgQ6kintYdzk1b5Tg2szG9uICDpU
	 2lAmTR/6nEz3w==
Date: Mon, 21 Jul 2025 13:30:59 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com, 
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix warning without CONFIG_VIDEO
Message-ID: <zvpa4rrhfgpnjdfk2e64qaneoavjs4hqe5a7zqnhtddprnvkbr@viutp5nqevnh>
References: <20250718134134.1710578-1-superm1@kernel.org>
 <rdqrqwoye3b4tut4mgqckshmlslycg2weyleasduxawhyoifq6@pyykudf4ncke>
 <b15cf1f2-7155-413a-973a-d632e5170596@kernel.org>
 <hwdswlzbejlrawrrsgdlqtmzb6437kyei4hl5uqpe24orey2qd@2u7i7dzkhfyu>
 <ca34c473-579b-4991-984d-4e037005c979@kernel.org>
 <5gthsstizscrujhx46ybngtuny2lafmjwaidykn4rbvi6lr2by@jnuryin54ghx>
 <793a0872-37a8-4fe7-bf68-b9072d7a6aec@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <793a0872-37a8-4fe7-bf68-b9072d7a6aec@kernel.org>

On Sat, Jul 19, 2025 at 08:46:04AM GMT, Mario Limonciello wrote:
> 
> 
> On 7/18/25 9:47 PM, Manivannan Sadhasivam wrote:
> > On Fri, Jul 18, 2025 at 12:26:49PM GMT, Mario Limonciello wrote:
> > > On 7/18/2025 12:23 PM, Manivannan Sadhasivam wrote:
> > > > On Fri, Jul 18, 2025 at 12:06:22PM GMT, Mario Limonciello wrote:
> > > > > On 7/18/2025 12:00 PM, Manivannan Sadhasivam wrote:
> > > > > > On Fri, Jul 18, 2025 at 08:41:33AM GMT, Mario Limonciello wrote:
> > > > > > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > > 
> > > > > > > When compiled without CONFIG_VIDEO pci_create_boot_display_file() will
> > > > > > > never create a sysfs file for boot_display. Guard the sysfs file
> > > > > > > declaration against CONFIG_VIDEO.
> > > > > > > 
> > > > > > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > > > > Closes: https://lore.kernel.org/linux-next/20250718224118.5b3f22b0@canb.auug.org.au/
> > > > > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > > ---
> > > > > > >     drivers/pci/pci-sysfs.c | 2 ++
> > > > > > >     1 file changed, 2 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > > > > > index 6b1a0ae254d3a..f6540a72204d3 100644
> > > > > > > --- a/drivers/pci/pci-sysfs.c
> > > > > > > +++ b/drivers/pci/pci-sysfs.c
> > > > > > > @@ -680,12 +680,14 @@ const struct attribute_group *pcibus_groups[] = {
> > > > > > >     	NULL,
> > > > > > >     };
> > > > > > > +#ifdef CONFIG_VIDEO
> > > > > > >     static ssize_t boot_display_show(struct device *dev, struct device_attribute *attr,
> > > > > > >     				 char *buf)
> > > > > > >     {
> > > > > > >     	return sysfs_emit(buf, "1\n");
> > > > > > >     }
> > > > > > >     static DEVICE_ATTR_RO(boot_display);
> > > > > > 
> > > > > > I failed to give my comment during the offending series itself, but it is never
> > > > > > late than never. Why are we adding non-PCI attributes under bus/pci in the first
> > > > > > place? Though the underlying device uses PCI as a transport, only the PCI bus
> > > > > > specific attrbutes should be placed under bus/pci and the driver/peripheral
> > > > > > specific attrbutes should belong to the respective bus/class/device hierarchy.
> > > > > > 
> > > > > > Now, if other peripherals (like netdev) start adding these device specific
> > > > > > attributes under bus/pci, it will turn out to be a mess.
> > > > > > 
> > > > > > - Mani
> > > > > > 
> > > > > 
> > > > > It was mostly to mirror the location of where boot_vga is, which arguably
> > > > > has the same issue you raise.
> > > > > 
> > > > 
> > > > Yes, I agree. But 'boot_vga' has set a bad precedence IMO.
> > > > 
> > > > > I would be incredibly surprised if there was a proposal to add a
> > > > > 'boot_display' attribute from netdev..
> > > > 
> > > > Not 'boot_display' but why not 'boot_network' or something else. I was just
> > > > merely pointing out the fact that the other subsystems can start dumping
> > > > device/usecase specific attributes under bus/pci.
> > > > 
> > > > - Mani
> > > > 
> > > 
> > > This is a pretty general problem that exists that attributes are first come
> > > first served.  For example amdgpu adds mem_busy_percent and it has certain
> > > semantics.  Now PCI core can't add that.
> > > 
> > > And if nouveau.ko wants to add the same thing they need to follow the same
> > > semantics because userspace will look for those.
> > 
> > But here, userspace is not yet looking for 'boot_display' isn't it? Why do you
> > need to mirror 'boot_vga' attribute?
> > 
> 
> I have a pull request opened in libpciaccess; but correct it has not been
> merged.
> 
> /If/ we're to change this, what would you propose the path to be for this
> sysfs file?

Obviously, DRM.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

