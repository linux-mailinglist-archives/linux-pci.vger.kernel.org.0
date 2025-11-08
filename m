Return-Path: <linux-pci+bounces-40617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6179AC42B6B
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 11:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A103AB038
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 10:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A5A3002C2;
	Sat,  8 Nov 2025 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ydn3h6FH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F432D63FF;
	Sat,  8 Nov 2025 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762598422; cv=none; b=bKSxCYVPXG+vUXX7wrgiv+BL7Vxg9RljBVHWtsk+Bli5cOrSxtaiJqvSkx+uzvkuTnZbUtx7SLsOFz1FlBHfF8BSO2dbRL4xd/F1qQ8+J2iNicouh76blqQtPNDw9ijw/D+4smBjK1ZugASjnvjBi3G9pzxAwZLxm0wEH5m08I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762598422; c=relaxed/simple;
	bh=zmpl9/6Gu+ycYJXFFYRN3iGuNWhx7bx2ECgx8oeCqZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsZdcLwzTYJ/7wFuGTaFDDAWLtcyYDWVDPYNgMZEJGjKHPo66dC2WAcGdjETJ/YUL3oEAZusvLG4Lk9ljagYMB+gkmZ2nBvm3Wve2Nr/9ymH6Z67VCviqiNvq11CHSGRy/pKWEnG5IfR+SSQy9aadR9FpCKo+WjLExteEsFgcqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ydn3h6FH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C53C19421;
	Sat,  8 Nov 2025 10:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762598421;
	bh=zmpl9/6Gu+ycYJXFFYRN3iGuNWhx7bx2ECgx8oeCqZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ydn3h6FHAWaeJdaQAb7LKY8bkJ2Mzixlyje4BUsl/nYnrBA9rZZmCGsNE6Tk9n4gW
	 NSTC+0wmoI2jU+cAywXO3Bi2C0fsrqOKmjwLYyEaw41Xx1WpXTNHQpIDwKcpr3oaJQ
	 r3vU26WNXYw14T3NfYYqu3unBjRRLUBJJVbhIISBjVg9kF4TSzcnVmBvjp21jnpt8t
	 xpRL7SqKni70GZMh+S+QHk8RtOZ4G981Sg8nCtc7iRNCc3L8E4hSM/wye60LIx5+Vx
	 st1xJe6fkLBLmGi57Sh99sl27+0qJKtO5oJBCASrJYYIHG0c+8t5+34jivkn9CIHMG
	 l2pVhVle6XvAg==
Date: Sat, 8 Nov 2025 16:10:11 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hanjie Lin <hanjie.lin@amlogic.com>, Yue Wang <yue.wang@amlogic.com>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Andrew Murray <amurray@thegoodpenguin.co.uk>, 
	Jingoo Han <jingoohan1@gmail.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH RESEND 1/3] dt-bindings: PCI: amlogic: Fix the register
 name of the DBI region
Message-ID: <65hstqcfcca7xj3cdtq7iikcdojbltfu42zlfdelskakesu3cd@hl3kydp6dw2t>
References: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
 <20251101-pci-meson-fix-v1-1-c50dcc56ed6a@oss.qualcomm.com>
 <31271df3-73e1-4eea-9bba-9e5b3bf85409@linaro.org>
 <rguwscxck7vel3hjdd2hlkypzdbwdvafdryxtz5benweduh4eg@sny4rr2nx5aq>
 <20251106-positive-attractive-tiger-ec9c1c@kuoka>
 <lsue7hlgybqpru3qfetlpee2mswnycvhxjffwyxtplmpqved2u@aohtwjtxesr4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lsue7hlgybqpru3qfetlpee2mswnycvhxjffwyxtplmpqved2u@aohtwjtxesr4>

On Thu, Nov 06, 2025 at 02:37:17PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Nov 06, 2025 at 09:30:15AM +0100, Krzysztof Kozlowski wrote:
> > On Mon, Nov 03, 2025 at 03:42:58PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Nov 03, 2025 at 10:47:36AM +0100, Neil Armstrong wrote:
> > > > Hi Mani,
> > > > 
> > > > On 11/1/25 05:29, Manivannan Sadhasivam wrote:
> > > > > Binding incorrectly specifies the 'DBI' region as 'ELBI'. DBI is a must
> > > > > have region for DWC controllers as it has the Root Port and controller
> > > > > specific registers, while ELBI has optional registers.
> > > > > 
> > > > > Hence, fix the binding. Though this is an ABI break, this change is needed
> > > > > to accurately describe the PCI memory map.
> > > > 
> > > > Not fan of this ABI break, the current bindings should be marked as deprecated instead.
> > > > 
> > > 
> > > Fair enough. Will make it as deprecated.
> > 
> > The true question is what value was being passed as that item (ELBI)?
> > Because if this was always DBI - device has DBI there - then what
> > deprecation would change?
> 
> Nothing, except not breaking old DTs with the binding check. That's why I
> decided to remove it in the first place.
> 

Neil, do you still insist on marking the 'elbi' region deprecated than removing
it?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

