Return-Path: <linux-pci+bounces-26590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E563A99703
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F605A5096
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAFC28D831;
	Wed, 23 Apr 2025 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7Hx2Et6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D6F288C9A;
	Wed, 23 Apr 2025 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430622; cv=none; b=EWl8MwbIAaGBW7+Swq44KA370QFz2c5TDv/i4Iz8T8KBMCkt5PGL8dXB+d0ALqjdCk9+5R5ajz5PGKSGKxcWkp55OqBgzg94KF+w26Qce2qrOtfAv8DJikDd2ASivifEuEbmEv9uVjsb9TqVXfX4LwmaXTOiC7Zp8BUC0L0AwIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430622; c=relaxed/simple;
	bh=Egp3Yszj4dH8xTnJVf5ZAxkxoyrRymUIA54q4ihDQHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yp/wOiZVp2t9fmoCp4DO1oaIYOzTxB/0NNvbvp/x2yHANL3vQ1HygET3bbDDo3blF1MWNdfYTME3GjMHDBEAq4GJhFmFVTT2iY9ntPDSyTlu8bjt50TlJ28Gx/bDwfsFGI7wCtYmAsSbdtdr0Wu51ul6kUGDxB5y6+GGkpQQUmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7Hx2Et6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EBCC4CEE2;
	Wed, 23 Apr 2025 17:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745430622;
	bh=Egp3Yszj4dH8xTnJVf5ZAxkxoyrRymUIA54q4ihDQHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a7Hx2Et6Gc58QrcEBYMSxR4ISbAAzxE36+ukyUOr7y3CPDLBhIK0sTsC0/zxaYHEl
	 DfLzLcxqfCD4RAV2ToZbpZcVkpYp5JN8u7F5tlZYVb63jscDdepELpvhqdihfd8MOX
	 L6sPy/Lfjtzs106AqLsHozQ+8Bir45pOHn2mPLpVGoAVPd4h5vAbe9gNKUyJ1W0SQ1
	 wSmoHkgyHZls087dZMOY0oikCvUsKNvVmlbq/Hr8OqAYMhneUHgKkAm5Vy4KWy9ttS
	 mslgMN1ZZn4Te57TvTL9m8CZXJVTXhHcKA2pcq07gliK+vZpYDMm8lNZX9ZzZjhxdw
	 2C1CrEmYmAXrA==
Date: Wed, 23 Apr 2025 19:50:16 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	heiko@sntech.de, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, shawn.lin@rock-chips.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 2/3] PCI: dw-rockchip: Reorganize register and
 bitfield definitions
Message-ID: <aAkoWCtCS7Lxx3Gx@ryzen>
References: <20250423153214.16405-1-18255117159@163.com>
 <20250423153214.16405-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423153214.16405-3-18255117159@163.com>

On Wed, Apr 23, 2025 at 11:32:13PM +0800, Hans Zhang wrote:
> Register definitions were scattered with ambiguous names (e.g.,
> PCIE_RDLH_LINK_UP_CHGED in PCIE_CLIENT_INTR_STATUS_MISC) and lacked
> hierarchical grouping. Magic values for bit operations reduced code
> clarity.
> 
> Group registers and their associated bitfields logically. This improves
> maintainability and aligns the code with hardware documentation.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

