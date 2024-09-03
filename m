Return-Path: <linux-pci+bounces-12663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4D6969F5E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 15:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18778284A9C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 13:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836E423D7;
	Tue,  3 Sep 2024 13:47:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4C81CA699;
	Tue,  3 Sep 2024 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371247; cv=none; b=CjzHA2qlzJWNWILwAKRADWMPSXmcrOVa74XkwFuaKKvbA5HXmCbxqnIEVYA3RH707hKhyv/Mb0KfO3t3RyTuFFYd6MhdPzcKVv5igyimNIr9MSiWA8K8+ECQqo3bZrKfyQ7e1M4Hb6G7LTxyCS7g0EzZyyzV0qSvMQzo/MMj70c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371247; c=relaxed/simple;
	bh=SqcWwZN4Aj62QILUlMxfJ+PTfmnTWxFUhKgVi8tByqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWl/+4liu+UT+hDVB3QthTSRjbeTsjOy2Vgwpm4ummadgP3J4x+DfyP+7d2Kqpar6ECdPLClRumqawfAIa4mO6f2Tw3gWdwPB3cWnDmCNerwZ/ZlAOLsDe2xHuPAKc6fuoTnyiM8BlvpMjybqYbbubrZU9qyAY+XrbVLQh8qU60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d89dbb60bdso2047874a91.1;
        Tue, 03 Sep 2024 06:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725371245; x=1725976045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVOZDWCkI5gq5GT1DRRpnaiGf/P82/ZwGLvkG+VkGdw=;
        b=g5p3XpTQzos9hzb68zETDPaos5jpiOuFal/uMOvfzDnQ1a7DxFRhRtlhqx3idKzrH+
         X8Bws23KK9kdWCjkjMumnRi16jfmSrxuYQOW6JkH7l1FigY44ueoWiuUrlls1n34J91r
         l4Y+t0m0pnd8WOk2PmMVVWgj2Or2HM3++Pij24QW++tuqJ5Chm4QsxMSx/VVlxA/6Qqe
         wxTzqbYG1SQaspDazgbpXEPGK58qwcVzlOt7y+CkJv1+Fjwky4jI0fYR9e3Ce9gTIhzc
         w0N/1h5XgED8bGIbo8Krk0i5kcAVPUtghaYfo6Kr7WHsrfdQm/FAsfllsDkVx9xK6fNJ
         Gscg==
X-Forwarded-Encrypted: i=1; AJvYcCU/xiH0Le4JQoshHzh3v5Q06+2ufc27cFdT0eVOOK4m4hqGWwp8Tf6eD4t7KBFf6VsmJnxQyR4Jrlot@vger.kernel.org, AJvYcCUmyXl2iHRK5GjlseNnJ00vP1pAlWqv+nW5q/xbnCNhOYlxVpTGY5ltRQOvq8nSNFs9fq+3tB3YsV3E@vger.kernel.org
X-Gm-Message-State: AOJu0YxoSP0De7jcaVaSmIA0OlFrRuFODM7H4guR85IkXJFH91XqmZ7b
	j/J2BSjw+zPQ3fZ2CY3uVjEMuyzz8XRa5a1I+Xjc1pnwed3oqjm5
X-Google-Smtp-Source: AGHT+IEhaO74x3D7NZ/N03KAk2Xu+dCACB1T+nWArP6VhDK7YxC8h/t/H6iyXhI45/BoQU/aoKy7DQ==
X-Received: by 2002:a17:90b:1083:b0:2d8:840d:d9f2 with SMTP id 98e67ed59e1d1-2d8840ddbb7mr13352021a91.24.1725371245433;
        Tue, 03 Sep 2024 06:47:25 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8edb8d4ccsm1328458a91.1.2024.09.03.06.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 06:47:25 -0700 (PDT)
Date: Tue, 3 Sep 2024 22:47:23 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-pci@vger.kernel.org,
	ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v4 0/4] Add Airoha EN7581 PCIe support
Message-ID: <20240903134723.GB1403301@rocinante>
References: <ZsRX-Hrn2fCITK4P@lore-desk>
 <20240820140133.GA207494@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820140133.GA207494@bhelgaas>

Hello,

> > any update about this series? Am I supposed to do something? Thanks in advance.
> 
> No need to do anything, I think Krzysztof will likely pick this up
> when he has a minute.

Everything looks good!  Bjorn, should be able to pull it for 6.12,
hopefully.  Apologies for the delay.

	Krzysztof

