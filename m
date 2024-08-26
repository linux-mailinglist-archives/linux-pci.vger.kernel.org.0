Return-Path: <linux-pci+bounces-12220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB54395FB1F
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 22:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F461C20CC3
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 20:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C6619AD81;
	Mon, 26 Aug 2024 20:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AViW7dk3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFDA19A296
	for <linux-pci@vger.kernel.org>; Mon, 26 Aug 2024 20:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705805; cv=none; b=UicFzxdzn1xER7k4XhZ2+d80DxIll3LhKYEIvBPD4MwCu1mqsHz3VBRK6l5sFR7awIUOSIKFCeLHAYdUETKlOeyannEBWqfeivN7AUjdKuTIQ1XBRNTFx+RIxeJ8xh+UMnqT7JLMeeSobqCqp+URs9Z0+ArJZHRBGL0+KqybMZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705805; c=relaxed/simple;
	bh=87Z/B4xSUgFs5kOkIxGeRlxJCuEY6tYguoq5IlFw7yI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqQDv4dHnQRhYt81rQH1shddCCRGxZDlc3L7rd1I9cqKC0T7oHdvXCrVz3MrN4XIBPMipzgxQMVzt3Z3xx3STIk2wx0hkZ94yNflzqcQJvtbHmEF7ufB1ibZ/QK9WHP6HhrYNSYmaLYZCBoPDeJVTreQPb/PYcqYgk5nZUZEymw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AViW7dk3; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e13cce6dc85so4898389276.2
        for <linux-pci@vger.kernel.org>; Mon, 26 Aug 2024 13:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724705803; x=1725310603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X9CVFLpyXCXDgP9THv4bNHAxxWsMLaXvJeEFc5aMssY=;
        b=AViW7dk3uoqgAwVQ0Fx1MBmQ+5z/mwM8iwsTHNpYShLgN0EzcJEWOBCGPG40EgF9V9
         NpPEO5EYkwM81KXCBQIVCO4i/hNNP007LgPcA5+tBDUaQ882VVllhMkcOvid7k63wpIb
         BZbhhFoveLR3uqDWtMYP+ghffO3p1jUE7vStk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724705803; x=1725310603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9CVFLpyXCXDgP9THv4bNHAxxWsMLaXvJeEFc5aMssY=;
        b=jhwcD+FFNqhdTN09BfnxsWCOy6kvu13VmVxINB8eAK3Lekxe2kx4u0k2mc8n+QQUkz
         fq392DtxLoI/UNAVNROtjf/VZlbGg1wRmymDSsUehlYPYigLYA6A/urL+OM80g60Y1+G
         itXAvb5e7sWN4bIa14+QbURcEZwTfqs7YigWMeIurJhoJomySht83GfhbNj0GEJIuFdR
         gSzZvivDllSu3ZeCRVcFsHaHADwMxJAjtnW8OqKGkJeaIKhCH2UufC15d6ESlamvJ3hs
         4jDzigOWDSv5vdkMZFQIwNr4O5z2QiW1SwdaP/hLvzmE/UyNltNgXsrWqRRIp9njHaLN
         vz2w==
X-Forwarded-Encrypted: i=1; AJvYcCVGFdtoO7nYINqGHXgp+z/eZzdaU4wDn3ajgrkb8urLJwxIm8BCCP42lZ/162gooO6VEYW0E9n9qj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YweDPgTdHI6Rh9RgISmxApUvp+qEWJi+iC/kd7PuOTvwEB6iF5h
	eQIOyt5AarHis/zcMRe047zKlFQK+G1omB9YaMjrfVUAAvJW5+3GPVEAd+XCXA==
X-Google-Smtp-Source: AGHT+IFSkDzCr747XdJ7y2gnBoJ7bElEmNET3/rwaKYI6AEhIRTqJfLSlXWwbEpLRNFbBK99sPVBkw==
X-Received: by 2002:a05:6902:1ac3:b0:e11:7f99:f76a with SMTP id 3f1490d57ef6-e1a2a9b16c4mr700051276.50.1724705802878;
        Mon, 26 Aug 2024 13:56:42 -0700 (PDT)
Received: from C02YVCJELVCG ([136.56.241.163])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d1cf6dsm50103536d6.19.2024.08.26.13.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:56:42 -0700 (PDT)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Mon, 26 Aug 2024 16:56:36 -0400
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, Jonathan.Cameron@huawei.com,
	helgaas@kernel.org, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, alex.williamson@redhat.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com, lukas@wunner.de, paul.e.luse@intel.com,
	jing2.liu@intel.com
Subject: Re: [PATCH V4 11/12] bnxt_en: Add TPH support in BNXT driver
Message-ID: <ZszsBNC8HhCfFnhL@C02YVCJELVCG>
References: <20240822204120.3634-1-wei.huang2@amd.com>
 <20240822204120.3634-12-wei.huang2@amd.com>
 <20240826132213.4c8039c0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826132213.4c8039c0@kernel.org>

On Mon, Aug 26, 2024 at 01:22:13PM -0700, Jakub Kicinski wrote:
> On Thu, 22 Aug 2024 15:41:19 -0500 Wei Huang wrote:
> > +		rtnl_lock();
> > +		bnxt_close_nic(irq->bp, false, false);
> > +		bnxt_open_nic(irq->bp, false, false);
> > +		rtnl_unlock();
> 
> This code means that under memory pressure changing CPU affinity
> can take the machine offline. The entire machine, even if container
> orchestration is trying to just move a few IRQs in place for a new
> container.
> 
> We can't let you do this, it will set a bad precedent. I can't think
> of any modern driver with reconfiguration safety as bad as bnxt.
> Technical debt coming due.

Jakub,

We have not said this on the list, but we agree.  We plan to replace these
calls with calls to stop and start only that ring via netdev_rx_queue_restart
as soon as these calls all land in the same tree.  Since this set is
[presumably] coming through linux-pci we didn't think we could do that yet.

Thoughts?

-andy


