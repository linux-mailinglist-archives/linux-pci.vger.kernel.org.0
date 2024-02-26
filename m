Return-Path: <linux-pci+bounces-4049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E559E867F59
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 18:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B5A1C20F12
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 17:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E79C12CD8E;
	Mon, 26 Feb 2024 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qQt090mt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9156D12DD9B
	for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970057; cv=none; b=gx38I1HNNOjBmaoOQ8J1NgIO4Wk37TFiJs/sUmN5kRNMXPgDko/Pl/ulMCzK7fDkx/FnHWsbMAUIrOxtoTUfvSBSO9Dxq3DJwXV8T9EobmIqZzuAxTO4SxQAACezRXZLThHMI5qquxCuaYBM6xL0xNAvP6Va1gQSiq1XF4Pz8oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970057; c=relaxed/simple;
	bh=nCBprRl7elMDgsu3Q+VfUSyqkYGuj7H5ht+7Gk7lqw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fv25JsfFgv5Mc8GsfoT7N04zLPhkWhY8nZXsU/ysLdGxY8jcLoz4/mkV7FyCF+UXf8kEZWoKbWAUp1dd7CF6epV3+M4f5eY87eUGgLhcMNga2/Swtn5xgJyA2E3oilwKcAZJ2vfokz6t2q9rVThKmBvqltj5va1+ra6EI6bTocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qQt090mt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc9f4d1106so3635ad.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 09:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708970056; x=1709574856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GsVc7UlGcxsksaiQoEbRw4jQmn28hv1EysTPYoFH4v0=;
        b=qQt090mthgDxxIg7cca73kASeyRqpKdPYVQHaSPC9ZwzTR7xsPnXbaZXqiBh8cHJNR
         dNym9qdAt0EKdEVOb6otlicinuqr2meOdof1Zzs7Mr4O7CPqR82GNNq7fnn1zDsz/oTc
         13f31pcOO7ldbtkoS/8K1CN4WWCJCHisWFmOL5pKqdrvN1KfAPchWPD9VRJvHOqY948d
         HoAiVQx4XLvYvQjnckHY2pHA68lDigbPzsI+bHwY/7gPcBZIvd2xt0YDmKn70bSF3lCr
         VKQ9MxmvQdULWBR4QtKaBJd54OabHf360d2Uo2cpwjWlkCLTs/8eWuhpRYVzXY+/xXdy
         tAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708970056; x=1709574856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsVc7UlGcxsksaiQoEbRw4jQmn28hv1EysTPYoFH4v0=;
        b=BnRwX82XUyoCFBq1BefNeF2y3U9iqLIimB3Eopl1wVX+H31xQu4E+FjyDRuONPkvjE
         kb/lnzY0XIAUJi9Mi5uE2gOXeS4SYY7L7w338xybkV2gm3wim8AiGRu4QiZ662jagCpW
         4T6iV0jio9OGNb+AvyQ5k6lcMA/PQX3awGjUcTr4D5KLcczuvit1qiD2sNjntlbGvhiv
         dxiypeZ176JiOIpmCRAKWLvnaGfh2Vjvgc45prnVREbZ9gNzVt6GoeoxuSU/zLAwsEay
         f0I4I9KN5599BfHZzfEJ7KkbUujPkpUNqGGt2pgnIsmUd0fCPrMD9TTu0OOL+wdzga25
         VVqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnBw1RiqHqm8tjFawTabzaQrQ3/o/hrB3QrWLYCYZw8QCTSKk4sNgoUqsasON6tHJIkNVvbdZjXzvusWpfiTcbSEXkeljRNYv3
X-Gm-Message-State: AOJu0YymEXP56LdjXWjr3AWkfxdQlCndpPm4aL3ySlMG04CdNl848lMY
	U66sDPl3JhWld6qAXkvCryV8cpabZdpk0VTIHtRjO3KHpwFbdsO9E/p7rwaxVg==
X-Google-Smtp-Source: AGHT+IEKS+AHrTe6LkZiDSjgsfP6iF+EINahMbkhYCIk/j6xzJ+g+VP+sDOgg3c5X7EajAMHMBrYYA==
X-Received: by 2002:a17:902:788a:b0:1db:4f08:4b10 with SMTP id q10-20020a170902788a00b001db4f084b10mr418657pll.21.1708970055598;
        Mon, 26 Feb 2024 09:54:15 -0800 (PST)
Received: from google.com (96.41.145.34.bc.googleusercontent.com. [34.145.41.96])
        by smtp.gmail.com with ESMTPSA id a25-20020a62e219000000b006e48e0499dfsm4312212pfi.39.2024.02.26.09.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 09:54:14 -0800 (PST)
Date: Mon, 26 Feb 2024 09:54:11 -0800
From: William McVicker <willmcvicker@google.com>
To: "Duffin, Cooper" <cooper.duffin@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kw@linux.com" <kw@linux.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	Ajay Agarwal <ajayagarwal@google.com>
Subject: Re: Kernal patch Add support for 64-bit MSI target address
Message-ID: <ZdzQQyAZtaxlr6sS@google.com>
References: <SN7PR11MB8281C67DF5E5B9EE8A1B9FFBF3572@SN7PR11MB8281.namprd11.prod.outlook.com>
 <SN7PR11MB82814D44B70D213918566050F35A2@SN7PR11MB8281.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR11MB82814D44B70D213918566050F35A2@SN7PR11MB8281.namprd11.prod.outlook.com>

On 02/26/2024, Duffin, Cooper wrote:
> Hello,
> 
> I was looking at [v5,2/2] PCI: dwc: Add support for 64-bit MSI target address - Patchwork (ozlabs.org)<https://patchwork.ozlabs.org/project/linux-pci/patch/20220825185026.3816331-3-willmcvicker@google.com/> and I was curious if there was a plan to have it merged with the main Linux kernel branch? It seems like it would be a great addition.
> 
> Regards,
> 
> -Cooper Duffin

Hi,

This patch has gone through a number of revisions in the past few weeks. You
can find the latest revision here:

  https://lore.kernel.org/all/20240221153840.1789979-1-ajayagarwal@google.com/

Based on the reviews it seems like it will get picked up, but I'm not sure if
it will make it into v6.9 though.

Regards,
Will

