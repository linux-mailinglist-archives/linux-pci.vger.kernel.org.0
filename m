Return-Path: <linux-pci+bounces-33234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9CAB170F1
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 14:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2AB621AD8
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 12:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCED170A2B;
	Thu, 31 Jul 2025 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q+Vkw9QJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2C12264AE
	for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964264; cv=none; b=FGPVFqlFXhZRcUCKf0/WAvcKpledcJ6R4nOZ+mYdZcKxvPa6e5ov/hwwx62DcIjb0IhMsOdsERIRR2vEnvXA4DEwa8I1VvOVpQBiVc639a2lwlr13uOLIbImvsim7XvVneFCs1qtfZvtRUJATiSqdf+Ux0P7dIyzaC8j+rd+ESA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964264; c=relaxed/simple;
	bh=lgkxQThTtfZZSUnIFCf5fUKUIMl2aWvIb0b/yw6y6ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBaIs0DQx7yEPD/TQ2JKVmbao2Wq/j7ghRaBugjtanx9vgmqWBw5sJlmYhV/aHO5I1awxAvsA4WnDOmnQI5NIuncHunxzT4z1xAU0Lat/b9SkX57IvoT/2pMpGBfe2+IjkiLwllmFhTqDaGZLh4UPskdHiTFmFQAkN+7UoV4il4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q+Vkw9QJ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-707453b0306so9249846d6.2
        for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 05:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753964262; x=1754569062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=32tD2N96Q6MQNin9/Lb0EqTq3IigVZXvJ6wxZCRCR/8=;
        b=Q+Vkw9QJozJhao4ea5k5AvrX9mMf1tm7HmZZxTlPUVTTq9fBgsZb+MhzE34iJiOWyS
         9lGX8N7+szXq83MR3Fqv8WPLshc39fF36OYQ+nk8Ewz5n/p1C8tv38kZ8bZ/dpegwhOi
         NxHkAyINfONzZ8GApEohSIGORWwAOaY1Eju4boORtkm+f8hlp4tRtl35fzBLZtl5KBuo
         s3G4ZZH7AOfAgYLo3ki24flzf//2mj6xXE+bwTkNZocigRy97XLcIFUSbHfOODC3r5Cu
         LSUDv7ZwEDMda6V4M4y0SFuFgLWU1zgd3G9Epv14J4K+HHRcb6ywaORLaBJHoDAMRvL8
         M/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964262; x=1754569062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32tD2N96Q6MQNin9/Lb0EqTq3IigVZXvJ6wxZCRCR/8=;
        b=TdWpEviCGw2ptRkUaX3IBxlcdkw0oqkh6HbdUYLNoQNz8Df8YJmUiOQkUpVabHLTOe
         ScjJQ4YS39VGn+bBlMq8kR4U0KFlZbtg8YtlzaiEegNsQASahNw8CkLIh68eAcXdJZHL
         DZkfJ3KxCXlrSZoe4Pv+3EnKDGSMIZ7uMdnH/gASWDkmtSPxclrCyFp0AxMDvXN+V5pV
         WOXxikaudoSnDRMLhs81XBoKfoFooXkgiN6DkCnJ6aYnmed4XVZV0g4k7pzs2DTYOhKE
         c32nJLg6ikaILH/Tb4lFRIRXDFTnsIq8vexDpLo05xlxI7k6ge3YvZtpxDv9aATgisBN
         zLYw==
X-Forwarded-Encrypted: i=1; AJvYcCV9A0d8viyckjgiH9P4Oo+8PyXljfxSXXeyGJGLBYQbVOcBhSdcy/Logo14t+14ZW8+A1xA7MsMAvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFgsEZRJDWHVbbjMedrM4LiKl3fs+HJ1dzOi/Ehi9Y5M6lW7f
	huEUgUPJSAlY+n3y5fMMqA7J0nfsfOLNfRoVUairI22noJDet6eSnPZEK4NHO8aTzWE=
X-Gm-Gg: ASbGnctwc6oIamuh8gSVMdS0ulw0sDklA0WJIyTeggcjNeO9o6CpwunstnK0hxX06WM
	EN7a114Wue63W75gAIYi0AhWmjEQdnGlTcNI3qYmo3EMObnUXqsUHa7D1YyCYZqNyKGiSEdUzec
	PpVh+SE5VDLZQfLm8rPXthjFJI1BWcmxRVX+Mdp/iLVfCaSbe3iPjSLLBDk1PXqoEqF/lAWyX1S
	YqWSqATaOPdrt1Q3IkdYegHzfSxzqWJvKe3fiiJ5ZfWxsD3lelN1YmwkGYKNS/evyxqauQTO0Fb
	V8eHXQ9ho/kANG4kfbDc5UMIp7Dym1OgIDf8WSyUO5a8jWHGx4wxdDTjDZJ9mzvVKJjlqFELS1b
	qUg9MrJLLNCMlAjQT3gUGbdtHj7ZDT5fKyNQuPApUt9fYe/doVZayYNLc6ql2mwO+Bxk3
X-Google-Smtp-Source: AGHT+IGlDd7T/UCTYlC3jJ27LG/kD/8HSLFnnlHhhhTVJjke6DkBwfMlPtU4g+DEqonThAsKUvPm4g==
X-Received: by 2002:a05:6214:c62:b0:707:62c5:9768 with SMTP id 6a1803df08f44-707670aa577mr86346366d6.26.1753964261687;
        Thu, 31 Jul 2025 05:17:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ca58d36sm6577016d6.38.2025.07.31.05.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:17:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhSE8-00000000oWW-2X84;
	Thu, 31 Jul 2025 09:17:40 -0300
Date: Thu, 31 Jul 2025 09:17:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 04/38] tsm: Support DMA Allocation from private
 memory
Message-ID: <20250731121740.GQ26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-5-aneesh.kumar@kernel.org>
 <20250728143318.GD26511@ziepe.ca>
 <yq5a5xfbbe35.fsf@kernel.org>
 <20250729143339.GH26511@ziepe.ca>
 <bbe2a41a-8f72-4224-a0bc-225c1e35a180@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbe2a41a-8f72-4224-a0bc-225c1e35a180@arm.com>

On Wed, Jul 30, 2025 at 11:09:35AM +0100, Suzuki K Poulose wrote:
> > > It is unclear whether devices would need to perform DMA to shared
> > > (unencrypted) memory while operating in this mode, as TLPs with T=1
> > > are generally expected to target private memory.
> > 
> > PCI SIG supports it, kernel should support it.
> 
> ACK. On Arm CCA, the device can access shared IPA, with T=1 transaction
> as long as the mapping is active in the Stage2 managed by RMM.

Right, I expect that the T=0 SMMU S2 translation is a perfect subset of
the T=1 S2 rmm translation. At most pages that are not available to
T=0 should be removed when making the subset.

I'm not sure what the plan is here on ARM though, do you expect to
pre-load the entire T=0 SMMU S2 with the shared IPA aliases and rely
on the GPT for protection or will the hypervisor dynamically change
the T=0 SMMU S2 after each shared/private change? Same question for
the RMM S2?

The first option sounds fairly appealing, IMHO

> Rather than mapping the entire memory from the host, it would be ideal
> if the Coco vms have some sort of a callback to "make sure the DMA
> wouldn't fault for a device". 

Isn't that a different topic? For right now we expect that all pages
are pinned and loaded into both S2s. Upon any private/shared
conversion the pages should be reloaded into the appropriate S2s if
required. The VM never needs to tell the hypervisor that it wants to
do DMA.

There are all sorts of options here to relax this but exploring them
it an entirely different project that CCA, IMHO.

Jason

