Return-Path: <linux-pci+bounces-15042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7319AB7DB
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 22:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3FB51F23B80
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 20:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B2E1CCB47;
	Tue, 22 Oct 2024 20:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNZGIvQs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23481CC8B7;
	Tue, 22 Oct 2024 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629906; cv=none; b=J4CbAmQ0w7vo0/UKvBPX4PWY7vVpBHAC7g2eRHuWr7mYRr/6e5bjf2yjZTgfEYp6JzJNh8TiqBWSlKLrEgqdRkaIoLV1eSGOEFjQn5EjiHTKe72Ntay1EsTfC79IgQBbaGB4IGYHUB79/hgpkxoZAkq/CJNMmSjgSVy23DwsxHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629906; c=relaxed/simple;
	bh=Q/UukEPUP32zgVTdK0YRVpQPgHsDur1KaNDdLcMAZaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekJ6hyuPtMQSYzvo+dB14U63DihlHSAg/9ytrA/f/MAI9MgU2w4pf2OTClbMuxQsXNSkNNVZmD+OiQA2bJ1RMME2t5eZ/+lAYPGssjBXNDBLS/CsX7RNvqn+6DHkhLBNr1aFUl2/L8QtTHXCQY8Xn9SyNa2preNeDKpUqix8YA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNZGIvQs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20ce5e3b116so48497645ad.1;
        Tue, 22 Oct 2024 13:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729629904; x=1730234704; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ktNgPCHPDjDnkh9XGkiZp/oSnx3cg7Ir6lSaEp/jux4=;
        b=VNZGIvQskhwAmcs2WSy7yWf9R3WNVWy1prdSfW+VtvzIxEvh1VPb3UEbxafHYvDlYi
         s8jRG2Li0m9e8FGD+8ob9MITWaydJ7VLXe+Stq6pm74BYg2i+66ks3ZMSO5RPRcsycKh
         dBZWdFVoTtM8UZyROijvMRMpKCG9y/VFctqNRJvkflxcPR75oC+04YCHOYYeM+UYCkAg
         D6ZTz9/CtPOQkmnTAlWO0zDe9dteCqPMPXJh9lBHxI21dhlhEjv2O+f3WKcK3XUCe9YF
         ea7l6+zhnK9IZGa51vULwJzUOW6gi9tCBfFsNDXN0U8EDdhxCgr2rUqyg9sSQg5EBU47
         s8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729629904; x=1730234704;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ktNgPCHPDjDnkh9XGkiZp/oSnx3cg7Ir6lSaEp/jux4=;
        b=NrdfokbHbsWE8S/1TEI3wwhthoSGp+mhnhy3siIjsN83eUSPHwBvt8uPIWSiuvrRkQ
         x+0EHfxX2bwdFYljIm6yo8U3i4YPXHecnTHCgLhyAjta5SjMHimA1K1oRBZqQr+G1Wjv
         BzJAFfHAsyj7qvk7Fxqdlfv1hi1e4puFH0Wx3cTxhAX7GWtBViaj4Nr6ibrSMdfi7iVB
         wAZzxgh3ul8gdwrjt8iXeLZScogBYPEM3Cfsb1Lef7A7rUQibYiFjyved2sLKg4dUIMZ
         i3CDyjecIwt0T8ikU8QbY5o3TGmvywaiVYfw3VR910Ftcpud0JIAQXA3JIiXXlHNOUc5
         lqKg==
X-Forwarded-Encrypted: i=1; AJvYcCVvaRIgvi7Bi/LAQ/apsVP8HVsWMnAH5J+AS7mnUl9kqtqg7G06nfMCYaH8aWI+K6bDzEgaRtKY407D@vger.kernel.org, AJvYcCX2yF8vyROrYahxd1SPaj7WmkJD8r7ergO5unZA80WkZ6ShG55BptEweGA1wPdkpEAZrIY72YptnQS2Vg==@vger.kernel.org, AJvYcCXhUmPQMIdS0LqjubLzZ9JZ3h73h6XrFbkLMglRLRfwpYHU4nFKBR7ATgP35VL9Q2wyqmUBuRI7PLVuaSXt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ATAxhpYkiABPXZlSwzaX6Ne99e9BX6/yq3EugSCsptVzIQL+
	9Z01BzJ63hNwnQm3768ByKfUaNl8wNW6Nb/WGZ0BegP5qLWX146k5YcyTA==
X-Google-Smtp-Source: AGHT+IFQ5f1JGWi+UhptttlHJLhSGC19qszYJatI3Fmus/EZkiudO/PZK4J5bokyc2Bh33lD9oHAQQ==
X-Received: by 2002:a17:902:e005:b0:20c:862a:fcfc with SMTP id d9443c01a7336-20fa9deaccfmr4717965ad.6.1729629904037;
        Tue, 22 Oct 2024 13:45:04 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:94ec:f4e5:1552:e2cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd48fsm46541925ad.129.2024.10.22.13.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 13:45:03 -0700 (PDT)
Date: Tue, 22 Oct 2024 13:45:00 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Move no_pci_devices() to the only driver using
 it
Message-ID: <ZxgOzHUqFDfBDedx@google.com>
References: <20241009105218.7798-1-ilpo.jarvinen@linux.intel.com>
 <20241010194533.GA575181@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010194533.GA575181@bhelgaas>

Hi Bjorn, Ilpo,

On Thu, Oct 10, 2024 at 02:45:33PM -0500, Bjorn Helgaas wrote:
> On Wed, Oct 09, 2024 at 01:52:18PM +0300, Ilpo Järvinen wrote:
> > Core PCI code provides no_pci_devices() that is only used in the
> > pc110pad driver during init to detect cases when PC110 definitely cannot
> > be present. Move this legacy detection trickery/hack into the pc110pad
> > driver.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Thanks, this is indeed a gross hack, and I'd be glad to eradicate it
> from PCI.

I would much rather remove pc110_pad altogether. If I can get a
"Reviewed-by" on [1] that would be great.

[1] https://lore.kernel.org/all/20240808172733.1194442-4-dmitry.torokhov@gmail.com/

Thanks.

-- 
Dmitry

