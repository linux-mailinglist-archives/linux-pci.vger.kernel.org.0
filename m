Return-Path: <linux-pci+bounces-24657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE47A6EE43
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 11:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3733D3B5107
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 10:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5DD1EF0AB;
	Tue, 25 Mar 2025 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="KzpoWJrL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59900255246
	for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 10:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900107; cv=none; b=CkOWq4PbCRZYvy7vwGNKuohOqYYobRdM4Hl8+XkYXPaObX0DJq0TYA8dDWjykR14KMPYpONK1biEE+SOyQQvV7dGT4feE0aZqHJL87J7tTSFIyxOY2VLePIis6e2wd7rxHX1J0sTH7XNlxyAGju8iTrtZHpCLdOcJb8YVv1f7HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900107; c=relaxed/simple;
	bh=XT5AJ+nHjXm8l1B72Wt67CumuDKgSEgPQdWbMcdml5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRuuyB9UR283sF6KDvYEKgv5SAHFR9GRxq2s94RKJaft8pfNwRl+XW8GdJuBMT3Xedgk3zLvXVhDsARbPPi3fh+zohQdfs7G9KJCPxWiOaHURi14MIRmEMRsgHW8nIa6nyqF0TGk14bO0F8upDApSt/ClfS5dz/t3FxboJ2rm3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=KzpoWJrL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224019ad9edso32615965ad.1
        for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 03:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1742900105; x=1743504905; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4cvwymUL0NvAVQbxd/v5L8Mbhjg/7BbJrcRQgHQwxds=;
        b=KzpoWJrL/EP06t+XThIBD81hEy6Od2EqT7p2V47zyOazBn1osMstV6c39zVpbWcAJr
         h0LxmrsIqGS4wXEY2Xtkoiol593PV5N3RTbl277mEub65h2ot5nBWjnF+AzWAQUJKryV
         /s/nVyKnPtzfnXtudf062tiT1rQW+Zyy3I7bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742900105; x=1743504905;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cvwymUL0NvAVQbxd/v5L8Mbhjg/7BbJrcRQgHQwxds=;
        b=INNrTA6/hXBgLCEADfurPUqdJWFZMgxxhEKDR6e1ZrheRzf5oKKIqQLd1RQZZ+CJL6
         BzYffmJNByXxAcBF34Kyw1VcsSrc/E2+Dd+T+TSkR8VKKDv8VAC8sdYHoIl+VSo3krfj
         vSKr9Sd6yv5BpMwX4IsuQOoVw0vn0O8nn6lrni35slIOcR5F/bfTmofX2WmjjVqTwjJk
         8W7SH2VpUXQ4A3oBe3x9dp2qZ3NSDSLeowQ4UBtZq953oga+hlNvH0gsIkI9Nh6g0ce9
         Jusp431CIUU93MHZI4qBM6UJsH5ejGgKqpKpZ/cVuVpQJJfq0wR8YeOKQvFSM+HGJBdq
         f80w==
X-Forwarded-Encrypted: i=1; AJvYcCUOmoNa7AT4pP5iGVPlraI3nZgAUOA1G0nInh9FcUSgo/ariyuJvMHxgh4R7asF3U3Bwk5TqD7h8/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhPg8/YhdqJe073w88qkI4Sfy+XQqAvISbUETtYfObVjC4uCnG
	+VQCuo5OHdSV8AhmNr8EwRk3CXyIAGHxtI2H2Z4A794tLFYzdIxBJEquYVCBuKWj5htGqPiSqX/
	l
X-Gm-Gg: ASbGnct7Fx3vlZmTgAuQQBAv0JuqCghRAM9kT4ZYYKfv9APCMY/hmLRIRZCOAHtCEhL
	MaUAsjdsmCfidzR79eBiz72CFafNK/Di+tD854BxihpBENOSY0U144waXC055uI5lnpSHIDcPs6
	SwVWwfUB5balgD4On80njBMiJn7y3DidX5gDsXw9BQ01GKtGbOQ+x8YgPYNy5NmjvC97m190OG0
	mX13YEyqPmlsEaLXV3scqVLHAXp+5Yj/xq+zUCyJeBk3YCWlLFtOYWaAKRdAiwVQpxqD94of3X/
	hqLiwJ2V94wqhWy6zO9EpS0gLCQlH6X37Xk+XmEWUOuNuhcdHA==
X-Google-Smtp-Source: AGHT+IGgGtIICegH8Sb6BTn8pdS68Ec79sYIcjMu7xJeM2n4kbkhryUYoDxYxkGjBO8+Yres0KmyXA==
X-Received: by 2002:a17:902:d48b:b0:21f:52e:939e with SMTP id d9443c01a7336-22780d8ff5bmr251332765ad.28.1742900105535;
        Tue, 25 Mar 2025 03:55:05 -0700 (PDT)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-227811f4383sm86448905ad.229.2025.03.25.03.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:55:05 -0700 (PDT)
Date: Tue, 25 Mar 2025 11:55:00 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Gomez <da.gomez@kernel.org>,
	=?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 3/3] PCI/MSI: Convert pci_msi_ignore_mask to per MSI
 domain flag
Message-ID: <Z-KLhBHoNBB_lr7y@macbook.local>
References: <20250320210741.GA1099701@bhelgaas>
 <846c80f8-b80f-49fd-8a50-3fe8a473b8ec@suse.com>
 <qn7fzggcj6qe6r6gdbwcz23pzdz2jx64aldccmsuheabhmjgrt@tawf5nfwuvw7>
 <Z-GbuiIYEdqVRsHj@macbook.local>
 <kp372led6jcryd4ubpyglc4h7b3erramgzsjl2slahxdk7w575@jganskuwkfvb>
 <Z-Gv6TG9dwKI-fvz@macbook.local>
 <87y0wtzg0z.ffs@tglx>
 <87v7rxzct0.ffs@tglx>
 <Z-KDyCzeovpFGiVu@macbook.local>
 <87sen1z9p4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sen1z9p4.ffs@tglx>

On Tue, Mar 25, 2025 at 11:27:51AM +0100, Thomas Gleixner wrote:
> On Tue, Mar 25 2025 at 11:22, Roger Pau Monné wrote:
> > On Tue, Mar 25, 2025 at 10:20:43AM +0100, Thomas Gleixner wrote:
> > I'm a bit confused by what msi_create_device_irq_domain() does, as it
> > does allocate an irq_domain with an associated msi_domain_info
> > structure, however that irq_domain is set in
> > dev->msi.data->__domains[domid].domain rather than dev->msi.domain,
> > and doesn't override the default irq_domain set by
> > pcibios_device_add().
> 
> The default irq domain is a parent domain in that case on top of which
> the per device domains are built. And those are private to the device.

Sorry to ask, but shouldn't dev_get_msi_domain() return the specific
device domain rather than the parent one?  Otherwise I feel the
function should rather be named dev_get_parent_msi_domain().

> The XEN variant uses the original global PCI/MSI domain concept with
> this outrageous domain wrapper hack. A crime committed by some tglx
> dude.

I see.  So the proper way would be for Xen to not override the default
x86 irq_domain in dev->msi.domain (so don't have a Xen PV specific
version of x86_init.irqs.create_pci_msi_domain) and instead do
something similar to what VMD does?

Thanks, Roger.

