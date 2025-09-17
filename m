Return-Path: <linux-pci+bounces-36327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 103C6B7CCC0
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206B9581A2D
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 08:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CAC1FF1B5;
	Wed, 17 Sep 2025 08:34:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE8D2165EA
	for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098066; cv=none; b=ngFY51dD+v6gDlYGvfYPb2/surVXOx4iOfG0LAmrIC44pWLPCE9KNBIa/QavMHce296hcS/5bboP8qjNC4lU1/DGOI2aI1fZoj40CT8Sxu0MRsXraP69GPrjeBAS8MPT0j5q5gAZQ8tEjCql/2YWVC1OnZIKRs7/td/3htCEGlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098066; c=relaxed/simple;
	bh=DySHDv2m6S2R7jAWa8eq/N59wBkeju6vKhFZnmHXvXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDpX+0sG9sFEMBIqb4by0qWMp3CoBu9y6BOQJCvN83ElYUDbsAkxEIGCwqKPe1Z1sRjnPFQenitt+qg7uaQqoXM2bGcV9pa6fLlfhzaeNBVhUcJHq5RKa5rxo/lSzBKPPTheyffAkwjzK8/5mFSlx7bh2acpqlMMKhBo6OPBpWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445824dc27so58585825ad.3
        for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 01:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758098065; x=1758702865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iELKTE0E+GlB2VJTAUrkTTPFqh84WW08eU+U9S+bUek=;
        b=ViZu0ZKsdl4nzwbxDZqAHMsK9wMznNUaLmQzNbnjlkQunsO8+2G19sqyENYbcbGFxi
         ElApnGIGCJ1fQI/35WGlDGTFwgfS4+qEdTWfkXuLalJxxxBMwC7aFwUXd4cPEoysV0+X
         4aBxGGqVHdRc05t6FGRqrRMNIyTtqplzCRWAZPTKseSnIt1ol/KS2mukQq1yoZV85Wmm
         p3plEnYSs6HMBvs1jbQVuF/dIY6nBHR20vCKG4iraLovhVf++NXMeiPrHgXd26P9CWY3
         v+hCwYWhULxvvi9/BSi4cTgytnDs2PUdkaftF162FOOR7PI27gLhz0K4QOlRVK0W7cVX
         D62w==
X-Forwarded-Encrypted: i=1; AJvYcCW1GdcAFsiU3ark2CGpBl35vYZQpdelsX+2MZXmeNZAshRxndKpHZSZKUs3oemKbvTUvTfDFcIIOGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKzSV0ja212HrZcA23tuINuHz02eW4Ui8Sl/goIrrQ75jlPLaC
	hxdKfku1AIZdGNpIrFVUsyBMvu7QFXqrDJwULC2vnOFNy+JwOxUyOrxX
X-Gm-Gg: ASbGncuhFV3mzD1ARqASh/W4OS5e2wfJ0WZA9F9QMHlBESblGmWGX38DBjLVOsrm5tI
	g4Z2g3SVmXMtgmnkVMstASDx76eNo3tT32gvSc+XmOMWlIupSLecl8fzASXKbq4CYEUMzaWs5Wl
	Jr0fN/IjWEUnv2zNAr06pk38qKeibnFyyC35bn6o6f6OrtJz42rmxBsA2c3zQESWGz9i4Aw6+Z8
	VVirewKS+gwHCnwEmMA44RhsGY/uPcviy8nt90N2rObxzl162xvkMjJBysz9xg9YC6VJJ6VliRA
	H7r/SH/8xGwV9/7N05mvY/4Dt1q5Cv7F4p0DXhSzETvgvf0WEU/1aycXeqNVRARiFCdGmpu1sH6
	KvA8B6Pt+ALJpjjnSkDoHBMc7+MwOIENKjXmKwKLy2/vk9hSR6zGIEzwsOw==
X-Google-Smtp-Source: AGHT+IEWZmuIT2HUy7KiXjjGo+jbGdy/oTHmqpbzleaSozDxJFqtOyIV47jaKlzA5JOPuqt5mZVuhA==
X-Received: by 2002:a17:902:f603:b0:24c:ea1c:1176 with SMTP id d9443c01a7336-268138fdac7mr15260585ad.38.1758098064706;
        Wed, 17 Sep 2025 01:34:24 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2631ee2ceb2sm111221445ad.141.2025.09.17.01.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 01:34:23 -0700 (PDT)
Date: Wed, 17 Sep 2025 17:34:22 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Matthew Wood <thepacketgeek@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <superm1@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <20250917083422.GA1467593@rocinante>
References: <20250821232239.599523-2-thepacketgeek@gmail.com>
 <20250915193904.GA1756590@bhelgaas>
 <aMnmTMsUWwTwnlWV@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMnmTMsUWwTwnlWV@kbusch-mbp>

Hello,

> > I can see that the PCI r3.0 (conventional PCI) spec doesn't include
> > the Device Serial Number Capability and the PCIe spec does include it,
> > but this seems like it would fit better in the pci_dev_dev_attrs[],
> > and the visibility check would be parallel to the
> > dev_attr_boot_vga.attr check there.
> 
> I'm not sure I agree. The pci_dev_dev_attrs apply to all pci devices,
> but DSN only exists in PCIe Extended Capability space. Conventional pci
> config requests couldn't even describe it, so seems okay to fence it off
> using the PCI-Express attribute group that already has that visibility
> barrier.

PCI-X 2.0 added Extended Configuration Space[1].  Perhaps why Bjorn had
different attributes group in mind here.

> I also don't like Krzysztof's suggestion to make it visible even if we
> know you can't read it.

I simply wanted to keep this new attribute and its behaviour aligned with
the existing ones.  Which we keep visible for historic reasons.

I don't like the special case it becomes within pcie_dev_attrs_are_visible(),
but it can't be helped without introducing an entirely new group for this
alone which would be an overkill, indeed. 

That said, no strong feelings about it.  I wish we could clean the existing
ones up a bit, though.

> The exisiting attributes that behave that way shouldn't do that, IMO.

A lot of then, as Jonathan also reminded us, predate kernfs' visibility
feature, sadly.  We probably won't change the existing ones, indeed, to
avoid potentially breaking something for some users.

This is why I was curious why do we need such an attribute to be added,
as when these new objects for PCI are added and gain users, then there
are often here to stay, with broken behaviour or not, sadly.  We don't
have any sensible way of properly deprecating things in this area.

> It's a waste of resources to provide a handle just to say the capability
> doesn't exist when the handle could just not exist instead.

I haven't checked how the kernfs side looks like, admittedly, but I think
whether an attribute is visible or not, it does not unload and/or de-allocate
any space for the accompanying kernfs object...  So, the resources saving
here might not be in any way significant.

1. https://en.m.wikipedia.org/wiki/PCI_configuration_space

Thank you,

	Krzysztof

