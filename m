Return-Path: <linux-pci+bounces-9412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6CB91C737
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 22:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4651B28238B
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 20:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D6E7CF3E;
	Fri, 28 Jun 2024 20:14:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3666F30D;
	Fri, 28 Jun 2024 20:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605689; cv=none; b=THSbU7HKQPQ3SF+aeTTH7J5FOzVI4Z95AS4kYd2Aot60c7B3MnQzU+aVWlwOMO+KiWZZR5PE0Xdyt+gSoP0eSs8GMbTcNxOTaYwr3iF5T2HGYR5hWFuespJH6lM1Hp63AgVNAUoD+DOqdNM83t7LIa1UyQn0yg0jblGzUXVU+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605689; c=relaxed/simple;
	bh=obCeelJAwx5GAnKZ4ry9wmPEI7cPJSqm7xpbG8rCpYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUrXL/P7P7iVc7VITQ/TyWwMisC40/D6m+ojtd1ZqtPTw3E8Bv0iaVokanWQvHrdbU9dlAs32UjCJXWes2i94ISEcdMDVcnNzZwVVzw3wamNTUjLQcZ/eFrbcDgGbWaql11oWZSWSpmmfJ4AJvPg4iKae3v+SESJNKXk7XTHY5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fa78306796so7177595ad.3;
        Fri, 28 Jun 2024 13:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719605687; x=1720210487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBDN2B5pDUVTWkXVifbegKXgqAIs059uvS0l5ghNuJY=;
        b=HUJ+rkREXudTBRm//ZHVmzivhKSiakJza47kvaOythHmmBfzEpefwoAjd7tv18gLZn
         t7VFm3iqm6Fr/y68E2O0TPVzwDx8wsy2jozwIESwk6yfaeZcWwzjJqNRs2agNT7tjsR4
         uF/FndBjjjyahdzj5FOi0L9ke4NirqdnD3IwI6NwfeSXA8q7pJ1HK7Hxl3ZlZFBsAjrj
         T8A7ErEYOrr4Wo1dxvjxf0AYu5g63jzmXH3vYbgHbfKHjC9Q7OklMUszR7XWDMOHc7fy
         DZCFHDHm2gBIkf2PusZLjtvIodIak/TvpamKezUOU7Ts4NvM8TEJL7gmvvSj2Qi2bnpS
         ri0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDC2rjnNeA5zcv30T7oGS6TTOkF0lVaF71QrxWdXf/oTQ1MJM7OgQFGydAZEkgLG0ysKHHYrzJ/3v1ZsGsPieOx4rGCQnAoQnHVVGz/N3EjTFGoiqtSFxvAMXiDLD86PpOIwaIWeJHSui4WYjs1lmqmRSt/I0b/OjR5vcsnNgWU/Byw8eT2LWKVW+dWZlgB+/ycM7paqie2mQxmxTQTzLJwcM=
X-Gm-Message-State: AOJu0YxghKQZPHYvztDcQPYXJBJEZW312iEzHCt+1D953nNqzJ+VdvN+
	3y7AbCW2Qg9zCVM5HGBHkKUPtJ5ODr7j0E3YYl4iTumNQx3wbQx+yZ0VgQ1OCl95yw==
X-Google-Smtp-Source: AGHT+IGSx9cHBNpDRJGVoxB1dkpda9AGwG0lC2I2mA9Ov9RfIcgLxQ1AOd2rpJvpgzEZZ/sLDcETqA==
X-Received: by 2002:a17:902:654f:b0:1fa:e69:f0e5 with SMTP id d9443c01a7336-1fa1d68d05bmr141482925ad.67.1719605687428;
        Fri, 28 Jun 2024 13:14:47 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d2060sm19986115ad.15.2024.06.28.13.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 13:14:46 -0700 (PDT)
Date: Sat, 29 Jun 2024 05:14:45 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v15 2/4] dt-bindings: pci: qcom: Add OPP table
Message-ID: <20240628201445.GA2206339@rocinante>
References: <20240619-opp_support-v15-0-aa769a2173a3@quicinc.com>
 <20240619-opp_support-v15-2-aa769a2173a3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619-opp_support-v15-2-aa769a2173a3@quicinc.com>

Hello,

> PCIe needs to choose the appropriate performance state of RPMh power
> domain based on the PCIe gen speed.
> 
> Adding the Operating Performance Points table allows to adjust power
> domain performance state and ICC peak bw, depending on the PCIe data
> rate and link width.

Applied to dt-bindings, thank you!

[1/1] dt-bindings: pci: qcom: Add OPP table
      https://git.kernel.org/pci/pci/c/1b029ce3b0b5

	Krzysztof

