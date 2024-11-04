Return-Path: <linux-pci+bounces-16012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B008B9BC10B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 23:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E233B20B90
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 22:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F05A1FC3;
	Mon,  4 Nov 2024 22:42:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CC81B6D1B
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 22:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730760141; cv=none; b=N/YVmNkHoDFLDbpv7asYvxM5/WsULQlftHM65ohTr7ZPEfIDEggk+fLGTEVGqoF15IjZMRBfJekX+ndma6qD6kL9EybwS5OmsVmwOb2FlVVn8/EoaOgixnXs1cBPdWGBZJm278JdiCzfvVkbITNo+c0EIpw3h5IrMQhVrjRgRyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730760141; c=relaxed/simple;
	bh=fPIjrRiLUOGOAVgVQX7BF9/DEnBpIqGZYuTRrqEAX4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtEWsDaWqT2/Nf7NjAYiX/8IBjiRDxYC02SO1QwLf4EtvChdFcLl87iulWYt/InmGuEQjRU9lVyEMCQ3DRY3DsM5s0dkklgIEz0Ax809M66aoMzmxBBcdzmX62joATmGZ3csledWUgenkN5B2Nad4CcOsH04TkHR5cZTPavMSZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso4085675b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 04 Nov 2024 14:42:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730760139; x=1731364939;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+332YewEMglEIpVSTReIiHk51Rob7zO1Ak3AWciE7k=;
        b=XuR6NgE4WOWWixBS2hKQmBarp4QzJGsv0+2Ot5D2aeQoguUKjRuDAD381gKhUHcpWu
         gBWxHhOzp6BiN5ehdBEEkY0vfpXI/xdiYQCF6Rgo3AoSULsnRZTvER0XJiFPOTIgFw3v
         OOoUuS/FOU9VAE/knLCi9LucQWajqi/Oar3UTEw9ltVlIeXTfXYV+DkUBPiDy4Pv+/My
         wDPvrDjgVR9fkWf+abxpqpr1f03unoPfA5ywjIU2q9vt6HMArJwgyDIATzkjPmZ0Hi0k
         BhXCJ7scmlWG+GJRG17LBLValB9zV7JHjFJarYMcVpXhqMwjouXR1gvp1TmCTjkEcQNU
         PNPw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ5Dk4YXVg4wYvQhDfhDpqt5DiBEs/vgLhwA3c6+wlDsh3qAVXnXL2s2RY8XiZPVF5KcGazs/Fr5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKiipgu00oOFRNoHTPdSiig177ZRWMy+yfXJ/SQriov+dYj4S7
	UNdeGyCnrC3aXOwvSDsxH/2mJEwm0wNMUxv+VeYPzyh5eD9X8kmR2UuJkehr
X-Google-Smtp-Source: AGHT+IHyqdGHagD1Z+I4bhZFGJvWSNZK06nZptLUvVFndCYBVRP3QvtacaCuLRcHf5jEFgjdjQ/jqQ==
X-Received: by 2002:a05:6a00:992:b0:71e:7ab6:8ea6 with SMTP id d2e1a72fcca58-72063093c2amr46565030b3a.25.1730760139007;
        Mon, 04 Nov 2024 14:42:19 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ed31fsm8059113b3a.79.2024.11.04.14.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 14:42:18 -0800 (PST)
Date: Tue, 5 Nov 2024 07:42:16 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C2=B4nski?= <kw@linux.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, alex.williamson@redhat.com,
	ameynarkhede03@gmail.com, raphael.norwitz@nutanix.com
Subject: Re: [PATCHv2 1/2] pci: provide bus reset attribute
Message-ID: <20241104224216.GB1446835@rocinante>
References: <20241025222755.3756162-1-kbusch@meta.com>
 <Zyk8bvQZou-stmrW@kbusch-mbp.dhcp.thefacebook.com>
 <20241104215332.GA1268882@rocinante>
 <ZylDjhRsIeslNc5E@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZylDjhRsIeslNc5E@kbusch-mbp.dhcp.thefacebook.com>

On 24-11-04 14:58:38, Keith Busch wrote:
> On Tue, Nov 05, 2024 at 06:53:32AM +0900, Krzysztof Wilczy´nski wrote:
> > Would you have anything against if we put this new bus reset sysfs object
> > access behind the following test?
> > 
> >   if (!capable(CAP_SYS_ADMIN))
> >   	return -EPERM;
> > 
> > This is irregardless of what the permissions on the sysfs objects from the
> > DAC point of view are set to.
> > 
> > Checking CAP_SYS_ADMIN capability, to improve our default security stance,
> > on a number of important sysfs objects (e.g., reset, remove, etc.) we have
> > was something I discussed in the past with Bjorn, but never got around to
> > sending a patch to add this check.
> > 
> > Thoughts?
> 
> Sure, I'm okay that. We are using DEVICE_ATTR_WO file attribute which
> says should make it writable only by an admin, but totally fine with
> adding this explicit check here too.

Thank you!

Depending on whether Bjorn will have any feedback to might prompt a new
version of the patches to be sent, if there won't be one, then I will add
this extra check directly on the branch.

	Krzysztof


