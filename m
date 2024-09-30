Return-Path: <linux-pci+bounces-13652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0282598A973
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 18:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82AD1F246F2
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 16:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56870199FBE;
	Mon, 30 Sep 2024 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtWpIN23"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C66E19259B;
	Mon, 30 Sep 2024 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727712594; cv=none; b=QGkVxU8KZKPBLWjUoQK4JVYXqLa01Y6+YazYG0GEEym2EeSEdusUqamjBI2tMtIq6mRlw9/IN9GUbhCe6/VUhFiq4ZUWgiNNsO26y8On5HQnokEjeylqTHzA2COLIlXST6uxF8F3lDXhdJ//pQU96s8yeEpMStl6JoMHiTZCyhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727712594; c=relaxed/simple;
	bh=lwyVM2Bl8IYbMSunG6pkG/5rQLyaRU4edXLuyBS0VJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NjN577GQ51812Cd1LPgh4MrGkBUC6/rFoAUym1os+28KBxoc0v6UmHCxgAstL/+qgQarT1fl5/+Rdh6lDU8ZwzSCnvsz6v1CKnjXjBPInsg5hGjbthpk2bdybbaO8eM1d+x1VISdFtX4O5nZL7Er8DICcQdksbjq7zEEn7C+ez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtWpIN23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99003C4CECF;
	Mon, 30 Sep 2024 16:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727712593;
	bh=lwyVM2Bl8IYbMSunG6pkG/5rQLyaRU4edXLuyBS0VJA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EtWpIN23Tu+8ZNECsyoDrvstvjo0qNmtvDo7jhn+lhlRHalzAkMQkrVZRJCBrugZN
	 X4T9SVIHunrjAZX+ss9lxCmdmP3JZTIeDUYE49et/gg5SE0iOnTA5zm0NwutoPXae1
	 dPbL4UgQjJTpU1g9CBa51zpOj9z4XLInc1KbszQrtBTJt1CMm/3fTfbs+oIeVGqv5u
	 ecNlXEQzJ3a++0SMUndOVcH9lL8OM5j42ZdxM5uCeU//POPclG5T7kDQXdtT6LTQ6n
	 tagynBO6xDa0rB67VrHnG5jb0q5w4re681WwRVlqEQL+NO455YLttw+vEkpqYPDX4S
	 JTp92a7Ua2DfA==
Message-ID: <95e25468-722b-4c6a-b8ea-b142d4a66f72@kernel.org>
Date: Mon, 30 Sep 2024 18:09:48 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: take the rescan lock when adding devices during host
 probe
To: Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>
References: <20240926130924.36409-1-brgl@bgdev.pl>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240926130924.36409-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.09.2024 3:09 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Since adding the PCI power control code, we may end up with a race
> between the pwrctl platform device rescanning the bus and the host
> controller probe function. The latter needs to take the rescan lock when
> adding devices or may crash.
> 
> Reported-by: Konrad Dybcio <konradybcio@kernel.org>
> Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Tested-by: Konrad Dybcio <konradybcio@kernel.org>

Konrad

