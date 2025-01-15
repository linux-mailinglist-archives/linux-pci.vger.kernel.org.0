Return-Path: <linux-pci+bounces-19875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1428A12283
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF113A3536
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66D71EEA37;
	Wed, 15 Jan 2025 11:25:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C611E9910;
	Wed, 15 Jan 2025 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736940350; cv=none; b=YAUDYkDJh8Bc+2pXbxJxWfL+6R8rByemBrb3PwwpvXxR7/XTuTOY2nPtMSpRltUouustYguNVTYA3RsWkGzTf5HILA3cqwwagySnBscaW4dNn8VsV1MZh/SxejI3uB04L2G0992lD4v/0u5PEa4sp+c5noMZ8SzAOjDpMnKOXh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736940350; c=relaxed/simple;
	bh=MMq7wyoUQe1E1AXYU+QSG4zgNKjbo63uF8hpmBHOIw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puXIOERSSe98zKfIOwpcLbFUps6XwznGaqsMew/jhUr6ajBXX1CWTNw26VrpL7TLNh1/oHU3P6rMJQgKjngc4IBUdlsxEsN5GZcXfC+LHKtU3mYkyIFvx/ZV6PN2jil0fjzT2w/1OgGp1LFBTWrGCNDNB0MB519Vm4nOeKadwnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21631789fcdso8875625ad.1;
        Wed, 15 Jan 2025 03:25:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736940349; x=1737545149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRG/whY4HK6KgYPyojYcUPL5aQ35YCDANn850tjPpCM=;
        b=undaQ81JmydIUCr5kOZQFcmHN36JdjCo/fEMHSTHMP8rcAxKSdva6onUNOwTd/GHwy
         lEC8zS/VFx5NOjw3Gv5QZbw7knIqtoB7BQc3owude0vovOqrzpBO30rBc8pPqJOh3bV3
         GD9+CujuyUU96E4kL2ZCGuGobFMqNjxuEZjsbasoT4DADDAZXSZ3NoPnMlgCMGmUhrbh
         RmB+mE/APRCrx7DOULtfMMiM7Aic6dxJe8H9UvoHGuD3RfdjaHS/DMht+EpnikLvYPst
         5jXqtjOB4EGGShEYSTFDM4t/+9FepP7Z/Bcof7vo860MHMRsQNlzDpsC7C5asmMaAfHU
         gP/A==
X-Forwarded-Encrypted: i=1; AJvYcCX2A9nSEKNGeynVp2J2WseeI/nTYqAGHwAQYu2409wCRMgiZQ9dfO6QVARPFXhPFIbsXmh/plPIM+ND@vger.kernel.org, AJvYcCXTj7RGA/cY4iectpbkZNCkXELlymVOH54jAWQ+eNMWpHgncSbyTFmBSSQ3/xt+jeNACa05HV7u4WTLgbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWox0stlBXLbTo/oVAbx0QbAMZ6ldjONFHA5/y8jFHHN30QLRc
	i4uYu7TEVQ+cuWODfmDVaYqlEWXQUAaATyPTOCJDSokV6fuACg4MyhFlba6z
X-Gm-Gg: ASbGncv+BiCczWPC6iRC+Cp2S/oGn+3cxlU5Ribp4e30qhQ0dv91yiRUUX0Q0LsX30U
	xpA8XD1LUybCN1CIwWAj/ay8pw+7GvtHB50KOGITzVHa4eR5EDNC9tMhS47xa5YQyzWCrQffwgQ
	+l739UdXK2uf9aiVR6zcPQmV1F3zfIBo+yyC686V2FxCe87T37dpTWnncziD4uN5DsBqZE0pMSg
	vqrKP/QyAclDxID7AUu2OVTDNCYdlIsmDuN+G+ClLYFDYsuHe/FQJBDLSWFU863Ja48Oa6+hm1V
	PbYkL2HzqHvIpbQ=
X-Google-Smtp-Source: AGHT+IEeY0favifc6MW43J/E4Byw65Q3kpcowpYUU4SrlNPJlNcvsTKfI9+AjlmoWoJ1ffNYRWkj+g==
X-Received: by 2002:a05:6a00:4482:b0:725:f359:4641 with SMTP id d2e1a72fcca58-72d8c4a3766mr3875344b3a.1.1736940348788;
        Wed, 15 Jan 2025 03:25:48 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d405493basm8955512b3a.27.2025.01.15.03.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:25:48 -0800 (PST)
Date: Wed, 15 Jan 2025 20:25:45 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Mohamed Khalfella <khalfella@gmail.com>
Cc: manivannan.sadhasivam@linaro.org, Frank.Li@nxp.com, bhelgaas@google.com,
	cassel@kernel.org, dlemoal@kernel.org, jiangwang@kylinos.cn,
	kishon@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: endpoint: pci-epf-test: Fix NULL ptr assignment
 to dma_chan_rx
Message-ID: <20250115112545.GI4176564@rocinante>
References: <20241227135948.ztxxx2u37og3ixxn@thinkpad>
 <20241227160841.92382-1-khalfella@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227160841.92382-1-khalfella@gmail.com>

Hello,

> If dma_chan_tx allocation fails, set dma_chan_rx to NULL after it is
> freed.

Applied to endpoint for v6.14, thank you!

	Krzysztof

