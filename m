Return-Path: <linux-pci+bounces-16943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 562899CF9C4
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 23:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031F11F25000
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 22:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABE318FDD5;
	Fri, 15 Nov 2024 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KSvdt2+v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C319118FDCC
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731709723; cv=none; b=QE8WXCfw1w68i8MOkwbeqQY0czBSopw6xQKMGmZDfGbm++L1IY+CrBz3mshqKZxDX5DF8T+RY+DFc/xoUR0AvPdxQxwJGYCkwejv8bGi+VJIW9cOYNVzvuuZBPi1AJG+v1t/rht9ruXhkcAjlHsMJATMFrtl9HWQSz31fm3ykLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731709723; c=relaxed/simple;
	bh=i2IhHfulyS75UGsF7/PqW4S9kdXZVMBDzqNzBpLvNdI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smCC+9yPOxvJBn1/zsyYKjbyoXtVP5lckWQU8W/myrbjxKKoQ5wRvZz7jSr4llYgAwka7cqeP7vTyG+xemLnAyL3dBxa7NRhJySYkA54dpxexCzbu8gl2xuzqhrUwgHAH7F986frOrU9ZfPU91DoBri0n6UGPta/cJxRQ3ahh9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KSvdt2+v; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b155cca097so184812685a.1
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 14:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731709720; x=1732314520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J+8l3D//FSODytWJh9ARkg7rtz2NFPnk8CFXEo496Tk=;
        b=KSvdt2+vnepVepyfsLWSDLRaUI0/1H1+KPbWPaDa0UtWEIny2rkZ9zFN8bTvapJ1PZ
         PfjSRzrq2HgtaaR8hZK2WAf/OFAAPlt/xBywBuDhU5JUAvUU9qbqkHUCkSuhXdD0xDEC
         Z2tkB3HZhP3ZwhUa3KFiuIW/X0MhJ3iNBW3UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731709720; x=1732314520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+8l3D//FSODytWJh9ARkg7rtz2NFPnk8CFXEo496Tk=;
        b=ZI2nBzmrjvlfl11lI/Lkd/YpcX+2nA1GT76R2TqFDKbn9ffLtaOBHjtj2Ko/eu+6vX
         v3/ttLSpmPhdiotlhOtXwyNyNDzdNav3rr9mjK0HDiAZA9ca4HPD0T/alM0RDMso33PU
         5YcTK+3xrFXlwM94frEc5ZY2TCp103S9nc0AfQMZFalP4PaP/Sn37uGI2LGQsgNYcwsV
         dnZb1igtLZGwh6YXhEneUz+q/NnZif3bqagHznKRBfrdDDBXyPzjxN+eOb5kmx3aDz6v
         OK+CFsyQ98NioUw4xbElFFqqthpROJKcfuGY/ISmxpsns5VMLfeAQBwErNq8LmAp8FOG
         FL8A==
X-Forwarded-Encrypted: i=1; AJvYcCUsSx/2HEGAj9tgQw9c4HkaBDDOJd/Idr+MGnqzOQumyNr5kYJKn2soMOOKzHnApepZfneHOWJ6n+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGw6kyUhZleWQiZZQ3Z3zcMKC7t4yyqkBtcB9C7JwXUnVm6jef
	UOg4u1XEREWYOBhz2EfL9RcPD3FLuXYbfFnX6ZdmQ9MEU1xhqJN2exNkZLztjg==
X-Google-Smtp-Source: AGHT+IHEJRVcqkSvSHdB5vLd3VF5G5QTq3MPd7V7tt3ym0x6SbftfZEGWwJgBwj4lbxJ2I1pfgtbmQ==
X-Received: by 2002:a05:620a:1a9d:b0:7ac:e8bf:894a with SMTP id af79cd13be357-7b35a51f0d2mr1310167785a.20.1731709720684;
        Fri, 15 Nov 2024 14:28:40 -0800 (PST)
Received: from JRM7P7Q02P.dhcp.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635a9eefd0sm24560391cf.27.2024.11.15.14.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 14:28:40 -0800 (PST)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Fri, 15 Nov 2024 17:28:37 -0500
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, bhelgaas@google.com,
	Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	asml.silence@gmail.com, almasrymina@google.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com
Subject: Re: [PATCH V1 1/2] bnxt_en: Add TPH support in BNXT driver
Message-ID: <ZzfLFSvHCaPgVPzH@JRM7P7Q02P.dhcp.broadcom.net>
References: <20241115140434.50457691@kernel.org>
 <20241115222038.GA2063216@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115222038.GA2063216@bhelgaas>

On Fri, Nov 15, 2024 at 04:20:38PM -0600, Bjorn Helgaas wrote:
> On Fri, Nov 15, 2024 at 02:04:34PM -0800, Jakub Kicinski wrote:
> > ...
> > Bjorn, do you have a strong preference to have a user of the TPH code
> > merged as part of 6.13?  We're very close to the merge window, I'm not
> > sure build bots etc. will have enough time to hammer this code.
> > My weak preference would be to punt these driver changes to 6.14
> > avoid all the conflicts and risks (unless Linus gives us another week.)
> 
> I do not have a preference.  The PCI core changes are queued for
> v6.13, so driver changes will be able to go the normal netdev route
> for v6.14.
> 
> I agree it seems late to add significant things for v6.13.
> 

Excellent.  Thank you!


