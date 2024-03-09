Return-Path: <linux-pci+bounces-4695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBFD877252
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 17:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C844D281991
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 16:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819FE1368;
	Sat,  9 Mar 2024 16:34:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0DE15D4;
	Sat,  9 Mar 2024 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710002048; cv=none; b=Ig2SMf+vvvAKdtfoeoOCzFWpuCucQeECtguZTWcg5/s5ksPWl0vDgEAzMIKSFUzPaUejoAuDdcDNnYRWfD1y4W0dZmCb68FGiYXIF07Gvd6rUowBnhCz4lDG42ZG9No7OSynmlo7WFFXUUvfPuNHSElYAtOupGLp5S0/lpEIYF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710002048; c=relaxed/simple;
	bh=wOxas9zQBEk8MEgIDUeQdmT6LSWMnnNmMi1Iiu4hutI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVa17JogT19GFc9lQ5oxkPh3K4kNzTgB8oQthbMwfBbc1BqWRwzbRt/g0KPzlFA7CW+fkN6ZF3TpDIYCRFthQ9JfL5R0MP/9RRiZGeszkl0fI0koNLbG9JGIL2IcqhdnCgebhaddmLVGoT35IjI4ewKU6pH+OQMqKLySKPAAxRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so1998582a12.3;
        Sat, 09 Mar 2024 08:34:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710002046; x=1710606846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYZp9jddQkF0UARYHJ3+5xAgWFAWRoZaLT/NQI28+QM=;
        b=nzbfRnUG6D95EgcrrU1PvGuGyw6nNUzmiSvqS1QCv56rbJ2yJWlFTlwggx1kY5HO0L
         XStc7xcdyDlr7YpUC6QJ2qS0D6d5ixEMjwxIm+IZjmTE4XXi9sMvNnFZ9EDtfXi+eyuo
         eF67BwDNdbQAFMSJoKqhnksv7PUh/ilCbTXb09NIy1bL1FzPx6QgrtKmNEAvOtKsENst
         zr44RX2FfFIiKeM5lDBIO5r8iCf3ne9Pjz8tLggbow31xHlKM1UP/wZNkpaJSl2UcwNK
         SLSD9CeDGfAdn1+SvrDMKITavITx520VN0FROb2SX01xr7IKxO5ikwM/ecXhYJv9QCKd
         mqrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTu3D8cNik/DHMo8+qU9diqTxKNJQ6BMJvsGDt6x5xF8EGfI8ozRwQri+HNAYfr2XWilul9jRPkUufIhQLM5trpZ97PlOQUUnNwUXnJBLZ+mvuTFbUG2RVNHDjSzE3FEatmE0iQ3MjagArXa+EdEa0spbIwu7PPOrlfP3PtalV3d59JvXXqIB8pTznC0DCwgWPhsszAthEcG+C5X/rKWHeNkg=
X-Gm-Message-State: AOJu0YzWFmERgJa5c/n7TDTftksPpePO23JrdIMU99jXBaGG5IsXgC4A
	HjpUpiIq4J20Tn+dPg/vkKetZvF79AVRttg9CP37nLqxqDFPCqx1
X-Google-Smtp-Source: AGHT+IH6QYEMBet29Snx7A1/EzWQv1G1V8qVQ1b4eMiUZJS86zsmr7KJ8OeTFHw1wpQ7/2n2vrT6HQ==
X-Received: by 2002:a05:6a20:e108:b0:1a1:4fce:8eeb with SMTP id kr8-20020a056a20e10800b001a14fce8eebmr1290706pzb.8.1710002046495;
        Sat, 09 Mar 2024 08:34:06 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id t28-20020a62d15c000000b006e674ef94b2sm1498312pfl.159.2024.03.09.08.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 08:34:06 -0800 (PST)
Date: Sun, 10 Mar 2024 01:34:04 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 0/6] dt-bindings: PCI: qcom: move to dedicated schema
 (part one)
Message-ID: <20240309163404.GC229940@rocinante>
References: <20240126-dt-bindings-pci-qcom-split-v3-0-f23cda4d74c0@linaro.org>
 <90a50ab4-a513-48af-b13a-bba082e49540@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90a50ab4-a513-48af-b13a-bba082e49540@linaro.org>

Hello,

> Krzysztof W., Bjorn H., Lorenzo,
> 
> Any comments from your side? If not, could you apply the series? I
> already have work on top of this and other people are sending patches
> touching same diff-context, so they should rebase on top of this.

Both series were applied some time ago.  Apologies for the delay.

	Krzysztof

