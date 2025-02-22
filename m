Return-Path: <linux-pci+bounces-22074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A23A4061B
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 08:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F081A17CA80
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 07:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BF020013E;
	Sat, 22 Feb 2025 07:40:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C08513C3F2
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740210010; cv=none; b=Z+MdvosE9ywjHlMwewS6dPUu8CRGWOlguzQL2kYty+s9nD4jsSC7psHdAYcTzwhkCtJE1Gk+dkfpXGB9a+4a1HM3zMN3m/6D9EYh0UOAdP4dSLdI6/quNDYq1G8TyzKvUydPSg0dZX+i0rDu4bUtXOQhsaWUL2QxNDc+etzBzUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740210010; c=relaxed/simple;
	bh=GOLx66YwRenzrY6vtDmQExmbf5CIPnSop6Y3We2zvas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3WoVMH8f3vD4PLvhP3bcceT59/eLjhYd+GxSgHIDmS+nGTFmf2CCJhl+NAgoOrpZtkd/GBg88O/LXV7IC7XPN/iwJuhCypXanIr/ukBnZ5mCsB/gOwYCvWUw/6yMVkyEUSa+3mGBBIOHN373lZxOG/48z6Hj85MI0uagvb1+oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220d601886fso43418995ad.1
        for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 23:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740210009; x=1740814809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIusnlIaDB7vYke+1e0zYGn7vFHQSaQaaWI2v/GjaBA=;
        b=Uvua3cEzhfk4S0gJj1zPp5pW+dEYJHZ+rZxdZunVXoOi3EUeB82cwRGQViCW7uKExA
         yIv1bVy+3e5STf6zAYy7jYLkhe8jq8505l4kbtBqHO2OorNeRODjWeGkWDvbg63Q7/k6
         1lH5SSZOYlLjx0JSruVUC2NnOnveIxwonZbrR8hSt4/SQ+WTO3GfW63fwUWSEAk8GcGk
         D8QRsh4YI9W9O6Pbm7szaJZoNtNFPwQ7A/8D729yw/+V5EJNVV/89VOv3k9gOagTPQyj
         JdLhSFLmdlKrf6XK0qKXAnbU4zoK4o/2V8HgJvGjvSiMhzefnlmlSk3kNIOhUpapMrn1
         /wWA==
X-Forwarded-Encrypted: i=1; AJvYcCXh1XSNgKzd91EeyZkLv8Tb1H/0WU9//mvufc/wp4BPzFQRywqbLMLXAi8FHGZ96LwjKN3Zdrdo6w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBv86Zy3plCiY0LWZ5+bcPwlR0+sIwqVvzrbRDwpZC91f1W3EG
	Hm7zgSUq9cYAYdc/6yTnXkLyD4zUm4jTwbpDekhxqZPwDsUZ/S//KR9Pf+IY
X-Gm-Gg: ASbGncsqCwyvWgX42dkPkn8lEMYmGFOt0WVIHrwGHL/xpbaqTsZm50yGIKwHQhiRh8t
	kUv9XM2Ja88e84qwzplirKrjiD8xaO4QzVXFcbieHRT/7HOHnUBQMGhBLBTYWRb0+KkXC1lEQ0+
	EgZjhcR3t2wXtydQwWHmEG+5mt9ArrGR0NRccdbhSlT8OgeoL0w8dIXcl2Uqeh8Yz9ama0ec1mM
	yFTu3ir1VMFjnZjMI9wSJiGuKJML0uz0yeCTulHQSTdqu+ruxSk+oUTF0vTkNIpNqjzvK7qguSE
	2/1F/fNdObjNBVQGV3Ktlf+Jj5IwivOsflyhElaioZhTIt0fI0V7zDqrOYEl
X-Google-Smtp-Source: AGHT+IFnWEQOVlYkIcAvpc+4gb6IcuOnH4l9CiuXOMRIhmSudHPiecnoG+O182vKhJcIbh+MxURY/A==
X-Received: by 2002:a17:902:f684:b0:21f:68ae:56e3 with SMTP id d9443c01a7336-2219ffa36a7mr101568035ad.39.1740210008634;
        Fri, 21 Feb 2025 23:40:08 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d53674b1sm148319425ad.98.2025.02.21.23.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 23:40:08 -0800 (PST)
Date: Sat, 22 Feb 2025 16:40:05 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: dw-rockchip: hide broken ATS capability
Message-ID: <20250222074005.GB1158377@rocinante>
References: <20250221202646.395252-4-cassel@kernel.org>
 <20250222000029.GA373377@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222000029.GA373377@bhelgaas>

Hello,

> > When running the rk3588 in endpoint mode, with an Intel host with IOMMU
> > enabled, the host side prints:
> > DMAR: VT-d detected Invalidation Time-out Error: SID 0
> > 
> > When running the rk3588 in endpoint mode, with an AMD host with IOMMU
> > enabled, the host side prints:
> > iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=63:00.0 address=0x42b5b01a0]
> 
> Maybe add a blank line and indent the message since it's quoted
> material?  E.g.,
> 
>   When running the rk3588 in endpoint mode, with an Intel IOMMU, the
>   host side prints:
> 
>     DMAR: VT-d detected Invalidation Time-out Error: SID 0
> 
>   When running the rk3588 in endpoint mode, with an AMD ...
> 
>     iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=63:00.0 address=0x42b5b01a0]
> 
> Too bad DMAR isn't smart enough to include a device ID in its message ;)
> 
> Can you include something here about what the issue is?  Based on the
> subject line and the patch, I assume something is wrong with the ATS
> Capability?  I guess this is some kind of rk3588 defect, right?
> 
> > Usually, to handle these issues, we add a quirk for the PCI vendor and
> > device ID in drivers/pci/quirks.c with quirk_no_ats(). That is because
> > we cannot usually modify the capabilities on the EP side.
> > 
> > In this case, we can modify the capabilties on the EP side. Thus, hide the
> > broken ATS capability on rk3588 when running in EP mode. That way,
> > we don't need any quirk on the host side, and we see no errors on the host
> > side, and we can run pci_endpoint_test successfully, with the IOMMU
> > enabled on the host side.
> 
> s/capabilties/capabilities/

If there are no code changes here, then I can update the commit log
directly on the branch itself once applied.

Thank you!

	Krzysztof

