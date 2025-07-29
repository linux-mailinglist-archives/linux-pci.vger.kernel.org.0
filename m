Return-Path: <linux-pci+bounces-33143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49038B155DD
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 01:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7D2167DA7
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 23:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8B9285417;
	Tue, 29 Jul 2025 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bgyG2fbP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F608111A8
	for <linux-pci@vger.kernel.org>; Tue, 29 Jul 2025 23:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753831192; cv=none; b=L8EIq33gOc9WN3ER0Pzo7MoOg3dosMBK/HtixTXT6h0k+a/i9kkP4VVdIETXXbYhPDLGg8em6gT2b388zJcI8zU+RtaaZaIt/hxuvPe0UQb1Ra1Bf0IiSY56yyxUfdM19yOsbaQYmyDUUp5bEswyjR0rqPFLiY1ORafUTOf3Kq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753831192; c=relaxed/simple;
	bh=c+qevVRK65+YEsONllF903kUYgjJYX41JiZtG9/l2tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/6WltczSsZiNVjNomRJOaeYvTISgWKI/DxmfibtsKUVkr3jxqNUsOXVfXEypeoF89vpfKNrbkr5yi+p6CyplfnqGyqGYioRk1I42ekFGJTXmknmy02kP3r1/b6FiXAsg3+wcoJn+cGxxhYG+4uQozs++ZsmVCaR1B0L/DZhe+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bgyG2fbP; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ab60e97cf8so75513181cf.0
        for <linux-pci@vger.kernel.org>; Tue, 29 Jul 2025 16:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753831190; x=1754435990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AMNPBYRiksp7mCFMd1azqDvewT0I1SAEyDTPXzSObOQ=;
        b=bgyG2fbP8UneckHcYn6Lfe2rUB9Sqfg4qgh5hRz96mzojxOR0PWZQjRn9nUdpI+u9u
         x2EqqkIpMmNbl8NT/7hYMK4UR4g3ZYoD/xoxcabpu9fA2dsuwdlSANYWZGwP2Ttuyg66
         T0PB2Y5zdcm66JuIgiX4hPDBkobJmz7VdyAAglvkNcmHAe1Of3s+7tk90PAcRaIEGP+u
         PP8/r6DIiT9P8tWduRvd+z0YpU6/PvXNExebiSr4EmppwMel908KgM2L/kxC6SAftigx
         L7FckIy67EpqCk694Cp2TCnTC2JUE+S/kC1zO3glPrNbVgwuUaNeAu6ScBV+3yCI0eIw
         dMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753831190; x=1754435990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMNPBYRiksp7mCFMd1azqDvewT0I1SAEyDTPXzSObOQ=;
        b=R1q+tHDV7J0KuX7z6vTrynJQ8SxKXd/Be/FobD6gMd4MOfEA4p4u9vAXbdJSme717q
         VmR1OwdWBHspsg8wWVXdqA2iSfwWCQpSQbjFfq8kQIN6nYq8Z3Xa3GdCHl7R9QAB1xyt
         YY7+ApXvg0iDk6yZnhdqeDupNuWt3/9WvckWy22r0zt2MCjZBuhAerMeLqTBZkJOAEOi
         BX0cUELrDtDqR9x5IgFVpG8EUO2YZvOWbOAjUcoovkorKmVA6ijGrU7tebyws2h1kr+4
         hTf16fg8/ao3K2dmnR/8IzVEH+R/7+1lsRmur2QJAqcMPzProtVcWzSi0UYnx4qHGBOW
         4YHw==
X-Forwarded-Encrypted: i=1; AJvYcCUFtdGTIHdXqOjw7bNsIcSZMYP1o0hgg+oVZmnHsfxpyMj0Ac7n4B1bRPf+EChep+a/XLUmCcAHW14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTfcRnSQ9pHalHeShZLJ7EZxS0L7WVsAgxG6eFoPmxkx3sChg4
	OJqWzxlfzMeFJzsKwm5hGUqDCu4wTbQ3d7OXEMO2K/EPBIRS2ixw6LiuJNI5A8inIVCkahi3UJ8
	syb2E
X-Gm-Gg: ASbGncscgzJcjLa2I+qf+hxCNYpk3pwHD5FTZAuF8kcoSyHksqyvsyiYRdUzQtxfuh2
	6CDW4EZVrp32LO6VHLBIu5OJB4CrBT7dbA5G+4z1kxFntcSfZSHzWzv2Lnh1y0n4zN782Ny+QU3
	IKgHtxqRDmTGHZRV8y/dQ6SH85k0kULb/Fx3CFIaBpnUO4Wx0iIZSY0Kt5FaQo6LC/rEVSIlu3h
	VrVHBr/LcFZwINnyW3hra7ww2zkASp4UaMlROg6z/WA2rXp3NJkJnrUHWfVCQfOvMsiC498lA67
	FxufS55Cg8oSlSYfj5Fk5lKkOhMBCoIwQlzE6Pi7v2s1QJ1lxIUMsEK7H6yTV71j2YvCzOhPAfl
	YS0HkfthVKHu3E9DSmOEEa6c0ziv7EbU0P5eOOj6hTegk7MqoVvvu6/gawCpqNTOWsRMtGcvWXA
	4TKbQ=
X-Google-Smtp-Source: AGHT+IEYB+v/aC52I3ETJqWCtvUpxpSoF5Ed5PqfVqNjoX+1qc9FE31iT0mWajpl0SB8iOsRrvOo2g==
X-Received: by 2002:a05:622a:351:b0:4a9:a90a:7233 with SMTP id d75a77b69052e-4aedb97af80mr26047401cf.12.1753831189896;
        Tue, 29 Jul 2025 16:19:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae9963ba4bsm54605101cf.31.2025.07.29.16.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 16:19:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ugtbo-00000000Mhy-3zTQ;
	Tue, 29 Jul 2025 20:19:48 -0300
Date: Tue, 29 Jul 2025 20:19:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm platform
 device
Message-ID: <20250729231948.GJ26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-12-aneesh.kumar@kernel.org>
 <20250729181045.0000100b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729181045.0000100b@huawei.com>

On Tue, Jul 29, 2025 at 06:10:45PM +0100, Jonathan Cameron wrote:

> > +static struct platform_device cca_host_dev = {
> Hmm. Greg is getting increasingly (and correctly in my view) grumpy with
> platform devices being registered with no underlying resources etc as glue
> layers.  Maybe some of that will come later.

Is faux_device a better choice? I admit to not knowing entirely what
it is for..

But alternatively, why do we need a dummy "hw" struct device at all?
Typically a subsystem like TSM should be structured to create its own
struct devices..

I would expect this to just call 'register tsm' ?

Jason

