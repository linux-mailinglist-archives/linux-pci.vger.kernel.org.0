Return-Path: <linux-pci+bounces-11855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB52957F08
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 09:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76725284C4A
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 07:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0291016BE13;
	Tue, 20 Aug 2024 07:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY1MLtsf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419A618E344;
	Tue, 20 Aug 2024 07:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137659; cv=none; b=f+jNCcw2EPxjddWQ5VELlwcT42FRXeUjaqERHQCV0g1v/1R2nfzbSiAnjMwMoFj8qR9wVGYRmgNy2ipHrEQBtppSK+qoFg7CxrkjPosl9jQlf/NKywWxSMZp9xAHJsnBiR0ec9fbUA+6mqNalIzeHDC2fslbcRIDuE5Z2TAf2CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137659; c=relaxed/simple;
	bh=N4cZaTiD2TAnKc/GtGJvPcFsd+MoWbR0Bq08kXAMQQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8iPiYG0dYVwqPTW+rz08Jd+ukyZ8nY7BtFRAe2taKljTm4AhsqbqlHSgBFox1NriNPxkgBEL3Odc8sgQX8Tsmrv7rmXkLfUiAWAmJP+cdrgcVgXjwvaTjKhb28MVaUphYza+LjIfjm/NMiqBE6bvWNwIs1gbSnNl+qlj6dKnDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KY1MLtsf; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so551367466b.1;
        Tue, 20 Aug 2024 00:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724137656; x=1724742456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NJq9e4lwDir8ymmK7BffSX8xHDk0ZjFLqMtAmgoT2DQ=;
        b=KY1MLtsfPb09YcXD3AnkyeGRWBTHqjCMSGJlic0yLMCp+K646Dokx9WPC8VpI2ErvW
         XLpOzGl0M9Ksci8eRhexFxEzluuDqFruzVV4LQYLXCA6I6BK8w+cbzWfJczQ11wamINJ
         weeOM00uGw92J/I3clYDMAncRZ+mpgmgdZ3fmAIRTGAG0ZjuLwAiUSNzqqyW6mMkbltY
         bwv/8b8z6VkkDGhswl3Idv4UDRfbbAjAcmx+9or1uKSh8vpXdosBxqxBrw70j3/bpYwD
         r1FSBiDCA0v8c22+UC7QKuNSkvsZvNF/BOVlYSA41r1QPzviIbNQVbGDph2GBx4aEiui
         CT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724137656; x=1724742456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJq9e4lwDir8ymmK7BffSX8xHDk0ZjFLqMtAmgoT2DQ=;
        b=khL/jYNtqJNyRvZxfK1sbRaqOh2RDXN6tF1AR69zeIl0L03yrmjR51d8+2DgbKzQhe
         prw5jm7GTqdoVChVAkzpWLOippt4syOkabv1gmrC97oahsxPPAm2QZsY8YRuEec00s2C
         cSgtLJjCRy/na1MKHKkbnG3RCXcI/igZFCcBLk1GnCokX2JDELTyGPBLAWJ+dKy2i8+m
         PDPveV+F26WdbRJos3PV30tcmIRiH6v+igNW0gr4YX2CSkWyDUH2nYlLmDDFpDKNUFNw
         vRpe+pPZpa1FsZMTsl4981tHX2/HEyU15MyyZBrpCeQVe2Ms+ypjGKIjYzs3yHrjxYsQ
         CuEw==
X-Forwarded-Encrypted: i=1; AJvYcCUpc+LjRxk0YitEm4eHEGdKEHWkPL2FcTOi4WIfh3oksRIE6cJxzt0xWaV4UbHMrMV/VmpxYQAmKWNe7tk=@vger.kernel.org, AJvYcCWF4yLt8ZAs/vzBIv60Cf35FXHSqs1/JYdVgjem3hQSoK2uRxLt5GDo5WgBCmyHcfBCew217LvMn/RM@vger.kernel.org
X-Gm-Message-State: AOJu0YyRAwoY1eplN3BfYuRmnFxQdvEulUraDQjnbesYZEFlH9smsM9i
	ANFUNL7VpXDwfLCodaJlTsxK/RK7mPP2+QJ++Sjmgu+SnKkMfp/Y
X-Google-Smtp-Source: AGHT+IHzHNJYjEadwnvrSG+CXQSDiM//fUFKgBI8g22Xkp6aRr+rR6REvWVZn4RKx65+5e1n1/4lCA==
X-Received: by 2002:a17:907:c885:b0:a7d:a4d2:a2ba with SMTP id a640c23a62f3a-a83929d3666mr926201466b.49.1724137656270;
        Tue, 20 Aug 2024 00:07:36 -0700 (PDT)
Received: from eichest-laptop ([77.109.188.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c7444sm725952366b.6.2024.08.20.00.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 00:07:35 -0700 (PDT)
Date: Tue, 20 Aug 2024 09:07:34 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Frank Li <Frank.li@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 1/3] PCI: imx6: Add a function to deassert the reset
 gpio
Message-ID: <ZsRAtlTDtxMYi6ug@eichest-laptop>
References: <20240819090428.17349-1-eichest@gmail.com>
 <20240819090428.17349-2-eichest@gmail.com>
 <ZsNbau03d5J0sLy/@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsNbau03d5J0sLy/@lizhi-Precision-Tower-5810>

On Mon, Aug 19, 2024 at 10:49:14AM -0400, Frank Li wrote:
> On Mon, Aug 19, 2024 at 11:03:17AM +0200, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> >
> > To avoid code duplication, move the code to disable the reset GPIO to a
> > separate function.
> 
> Add help function imx6_pcie_deassert_reset_gpio() to handle reset GPIO.
> 

Sounds good, thanks for the suggestion.

