Return-Path: <linux-pci+bounces-22203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B6CA42280
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 15:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F011B3B7AE9
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 14:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DBC78C91;
	Mon, 24 Feb 2025 14:02:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEB951C4A
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405747; cv=none; b=isrbonxj6DDRQNJki59GOErkJP+fbx4VPk6l+FtObhWCLjyDr3OZlj3F0mT45N79LfvDbdh1t8yHm1JUYpW1Vi7RTvFW18YrzQP5a49b+k3j3ljV3rBS/3ajOl+ECggAlun9XKxyMZ9kCE7ITj1EJZxbcLx4b6VOlJnzA5yxU0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405747; c=relaxed/simple;
	bh=6Zs45IK+vcbf+KSj6/B+pSzBWHRAf3d+HbK2MFNB6DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhcQfODo2z7Q6+1oesPOnVD9RIxbxELzHJKrpmTXusLhmNFPQ7TTFeFD6VoXuh6w+y8ZnBDHNIgCyaryivsrfeLiCss6LoWun6tA+VlcNXiffWJBnKAKfwoHMBnULPKUmdk7qqlS0H5j4+t2H7kKtrOs42LoHfM5BN6J1Sh15KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f42992f608so6899433a91.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 06:02:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740405745; x=1741010545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpTN6d+GpNPQWSiFhmHCwH/TLGoT2GAeAmtMC/eNPW0=;
        b=EmwsFZYnd9IdcBIYw2TLj0tTNU3c+/T/cq3isy7S7foiNj/qED5Gx8J3PGcg4WWlr3
         Hevg4k+Kc5MsLtBc8jZtgHHcdWmgTX9d+rwNEHv62+uaVsjpHx1e6mI5D8laNPmOcwyc
         wdQZRnWLDykqWQ8JUoQheU3NNgOhxcB8ZyqVRIH7muaBEcZPHUJnr3dmEbwZRY3DV8qR
         yMezrXUGLyHYI24lESAk+Cq01JAbAr/t0MKIJXMG/0GjaqtWDURvQl+dHeHnVJYY9Hp3
         ODB0RREcJciawCoNxxWQY2H2cK31Hr3OSn40qFcbBAt5udi0/5LkIcO2Iwg5i1ZBEOco
         vPcA==
X-Forwarded-Encrypted: i=1; AJvYcCVgA6M8Ka5NS82ncxd9RRFdcWlW1pEDBNwz81BbxBs1FcZd6PCUbl8HPzvFlvq2yh6NQEfl0D74pmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0IS+Yu36bqFbvOyfDe5g9iEdpjuuAD9+lpoBxd8Z4Bx7U/hzl
	exbRORu5Czmwpes5vyzq9+nX5x6sqz5kORcI1U1PxW2I0vprreSsjw21+AEZ
X-Gm-Gg: ASbGnctW1AKDZBok2cNOVlHy83OpHVuvfItnArJP5LIASEO2liXyNTNNKSMMDZIGV++
	Gq77YneeRHgI5R45j5CK6TzLDBUEx7v0auULvnHbv/mXhnQQN3GiiQpPHg3ylvkallkHm2PhObn
	EycAIMUp9akO+sKuuRIfSdEyoI1tj/AfdKqaDcD+KCO6xVUcYUMgqX5DTRcCCdCvS8ILLXK4OUT
	/oS6pzhy4kygGlx6eHCeqFBjWrWlNify3Jkkk400gVtDXGyzfeCj/iOKHTfvg225fWkvLnMz14g
	rcKykduWx4pKTW+XJD1gpyiX3yjDf083GK7oYIqWCXGdBZfRKCM8l66Ufz9e
X-Google-Smtp-Source: AGHT+IFUb0XwLM820eZTVkvlg4RhUB+W+8lZESE0yEwKGi4+M2/Xfy5Qmu5gmx3rPKEnyMPXBr50UQ==
X-Received: by 2002:a17:90b:3d8c:b0:2fa:15ab:4df5 with SMTP id 98e67ed59e1d1-2fce7b3e2d6mr18627489a91.34.1740405745115;
        Mon, 24 Feb 2025 06:02:25 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fceb10fab1sm6536710a91.32.2025.02.24.06.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:02:24 -0800 (PST)
Date: Mon, 24 Feb 2025 23:02:22 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: ep: Remove superfluous function
 dw_pcie_ep_find_ext_capability()
Message-ID: <20250224140222.GA76745@rocinante>
References: <20250221202646.395252-3-cassel@kernel.org>
 <20250222155002.lnig57ku6treeznz@thinkpad>
 <Z7xzOSBgSeHrk4xP@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7xzOSBgSeHrk4xP@ryzen>

Hello,

> > > Remove the superfluous function dw_pcie_ep_find_ext_capability(), as it is
> > > virtually identical to dw_pcie_find_ext_capability().
> > > 
> > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> I will be busy so will probably not have time to resin this for 1-2 weeks.
> 
> Perhaps patch 1/2 in this series could be picked up in the meantime, since
> it really has nothing to do with patch 2/2.

Sounds good to me.  I will pick it up as a standalone change.

Thank you!

	Krzysztof

