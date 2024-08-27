Return-Path: <linux-pci+bounces-12262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8CA96072B
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 12:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96EBC1F26B60
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 10:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE85019EEB7;
	Tue, 27 Aug 2024 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHr5GMv8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3BA19E827;
	Tue, 27 Aug 2024 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724753413; cv=none; b=owmrRZPmd4vNalglvWP/zWL/F/UtsOLt8EPJzXqZ0B6UUh/PbaOt9cDh4zEEUxMuOxxNurzDrzxJqbz/eiGTYUfgUz9Izh2yAeiAO+gYXlxRgEnjQ1qU7eCrkvp46Wuvbu/fyDZt7r6wQUE+jfvus4/OBwUKOWndcO6Y4MZ671c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724753413; c=relaxed/simple;
	bh=iIII8uSaRKyDOpwUGIfxHC4xjAJBRRgRehDKNEWdEG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BpQQaOSwwTDq6vHog6Gm84UCzExOKjKAMPQbqdiAz+P2RpYH6PI8w2O941V3539cm5JDVCO5qxr7ubrKBOPykQI+HR3l4PQSeru78vp/AVJqrUrKmPMxfJ9sChrlX58d61Lxv9+pk99WLbEfZzutxwhSZ1N6ki+gjod2y71jpAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHr5GMv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A31DC8B7A5;
	Tue, 27 Aug 2024 10:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724753413;
	bh=iIII8uSaRKyDOpwUGIfxHC4xjAJBRRgRehDKNEWdEG0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JHr5GMv8Ve+9ftdjUm5Tp/80LIlua4wDiK/fmJ3QiA/YbpZ6V3l92PeV2CVAcxbmd
	 M14GYFkCGn3nLCXu2T7Utirem121ZDhVGIxcVeR4oVHSIuYAwd197B/Adbwwa64tsc
	 Spp2WQhGVD7vvPHL2DgkFXHN3eSMRxV3PZ6GZ8lXfuDuNxrWwfpx1SLPdkVAYIlBFq
	 Xe0AC8HYcdBIfHNFw0u9ppeapApXhZWJLkr8LMYzE+HYbOyXOKNgRUuwN+lHMISIbO
	 Y0Y/ezuoBMFQKfWkLOJN2zNqnJi+R3plJ9OkG2kz6lA4UrSW5oCifEKeUtiWmVfsSB
	 qIYUYiodKubIA==
Message-ID: <9ae8b751-a6df-4775-a207-0d203f7415de@kernel.org>
Date: Tue, 27 Aug 2024 12:10:04 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] clk: qcom: gcc-x1e80100: Fix halt_check for pipediv2
 clocks
To: Qiang Yu <quic_qianyu@quicinc.com>, manivannan.sadhasivam@linaro.org,
 vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org,
 quic_msarkar@quicinc.com, quic_devipriy@quicinc.com
Cc: dmitry.baryshkov@linaro.org, kw@linux.com, lpieralisi@kernel.org,
 neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, Mike Tipton <quic_mdtipton@quicinc.com>
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
 <20240827063631.3932971-7-quic_qianyu@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240827063631.3932971-7-quic_qianyu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.08.2024 8:36 AM, Qiang Yu wrote:
> The pipediv2_clk's source from the same mux as pipe clock. So they have
> same limitation, which is that the PHY sequence requires to enable these
> local CBCs before the PHY is actually outputting a clock to them. This
> means the clock won't actually turn on when we vote them. Hence, let's
> skip the halt bit check of the pipediv2_clk, otherwise pipediv2_clk may
> stuck at off state during bootup.
> 
> Suggested-by: Mike Tipton <quic_mdtipton@quicinc.com>
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---


Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>

Konrad

