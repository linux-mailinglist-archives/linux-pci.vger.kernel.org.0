Return-Path: <linux-pci+bounces-7604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2858A8C8535
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 13:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70922832FF
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 11:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC623CF58;
	Fri, 17 May 2024 11:05:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDC11DA23;
	Fri, 17 May 2024 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715943938; cv=none; b=cL16z7HeYwALSenrSq7f8l4E8EZZIaboE9lpPRTANCyYxROuSnU+ccGXyHCAI8OIChDKa9wEijMBSZvQnlMJnPxdXaiWB0Y87ka34ZtP7gOCgaEd9Wu1f3sFNom0kdwEYzhN0beYvGxawIaNNh77eIMPbQB3yY6q9eMQG41mUFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715943938; c=relaxed/simple;
	bh=joiLGwoaKTuni3oVmgyg7NhIzlp5h0zbna1gE4Ju7BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/sGqFSf6qZ7C1WBvZZsXHWGmPAvYV9vFKWnmZBJygqhA7B4R1WZ0VYoyNF5e879qVnfs9JjUgbhYkQ9Q5qmjZU00/59dizT0McXcdsJf+SvkZ4Ikamx3Y6EW3dcBnW7RiU+g0XcccwQ14D5GXPB2ptACAqj4XaLmtn5TyaLg00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ed835f3c3cso5280995ad.3;
        Fri, 17 May 2024 04:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715943936; x=1716548736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9C2Iabb3KviDiU9pcCXgYKqv3XsqyMThgxMVc/vM2p4=;
        b=l7TPVuhAxQhXsprfVy10u6UOPcYg6srOOUyzyDkuMQlfLV8Kt5eQ3frS0UFzmvnQry
         VpcSkvirJXSn2FE7L+Gmi/sgSX93t3cq/e1nXctH7GwEwzfodjlKLVJbGuGzuWmMcRqw
         0wiW4IhceECrQu33kFYwpEJ2ZsoU92xk+XbWAuH+GjGKiUdCT3OTXkuPxMzHlFghioZV
         siKrR5BGrzMOJHuTxCWNWFDkgdb3l1P3mCRwnaOWNo4QdkgXYWm6OH0FlObuggptqQIg
         3Ul8lIETwyB61g9s+Fxfkzu5D3sjzz1cqoaAdKzvwFRprAhB91fXoRbGMleSfZmJSLF6
         OdRw==
X-Forwarded-Encrypted: i=1; AJvYcCUClWl43oX5cyQYBDOa64oIaW5HzVTC/K5MN/v9dWNzXgm5S3kXiDBLsk3L3l62JIwetQzNtboUy5rhWKriKhfDoaA92BE1D3bdihwfrwdnhiTlJv2jlUUioakTWY0iZWBq6rbLBhs/t/0ggy0qwgpcMqzETq/3u6Gurl1y42NoB0cPzA==
X-Gm-Message-State: AOJu0YzjZnuIBzHyhcvhZrV4xBEOq7cpYNoP9W3naeholxG1g0g/+mYK
	Ehc8Vppja0xuD8Y3XoQcydFBg161KsVyKkpkG+hGwAFZWZEHDju6
X-Google-Smtp-Source: AGHT+IFVZdoYJON530fO2X5rbONRy5CjwQQ+lZEF08uQn3U+A5Sjp3qY7qXlWDjUU4wnnrZPzKSgXg==
X-Received: by 2002:a17:902:74c8:b0:1ea:cc:b59e with SMTP id d9443c01a7336-1ef43d2e3ccmr209410165ad.19.1715943935982;
        Fri, 17 May 2024 04:05:35 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad7dc1sm154334805ad.89.2024.05.17.04.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 04:05:35 -0700 (PDT)
Date: Fri, 17 May 2024 20:05:33 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: pci: layerscape-pci: Convert to yaml
 file
Message-ID: <20240517110533.GL202520@rocinante>
References: <20240207231550.2663689-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207231550.2663689-1-Frank.Li@nxp.com>

> Convert layerscape pcie bind document to yaml file.

Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: layerscape-pci: Convert to YAML format
      https://git.kernel.org/pci/pci/c/24cd7ecb3886

	Krzysztof

