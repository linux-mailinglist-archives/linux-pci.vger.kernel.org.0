Return-Path: <linux-pci+bounces-13115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D59CD976BC0
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 16:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FC21F232A6
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 14:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101861885BC;
	Thu, 12 Sep 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5iivF/H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D096A2209B;
	Thu, 12 Sep 2024 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726150566; cv=none; b=LNbn96GIog3BVtAoE632t2ZTGGFpAuYXSyZZ78xdLnE897X92W0VqmT/DrrR9s9rWKTHY2LMGQiN+iJGFoKWSsDbjdQykOSDJER/bPzJVUusUYd2LAEA1/Ivvx9LJklpJ9t2EMw0q8EaTw7AnqN0yXWhEw/RnMhxEfQ4uvASvMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726150566; c=relaxed/simple;
	bh=fVIETZv+H9p1/it8eBQidsDxsQ++8d/hnRorBQfS3C0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akXpZsAiOK7w79NsgXPt2eGuJdE0jvanBPYzKRqhNAxI9Xyg62nFFeB4LgT4ShtdsH7EbXIrLZ7Thh4LnDlbqrOPEfksqpe6eI4KamyvFOtEuvLuVep1kBAx6AVpaG5rgCyC4B/kh5zgTHnlvekH2x/Y7QC8pEWQnlA1uz5Puvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5iivF/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01140C4CEC3;
	Thu, 12 Sep 2024 14:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726150566;
	bh=fVIETZv+H9p1/it8eBQidsDxsQ++8d/hnRorBQfS3C0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C5iivF/H28ePrgwhxHcJmm5659Weo5AOrMMA8JYewHHjPvLnFa1WK8qNA3N8PDkOQ
	 a+B+BDhF1/6uutnd7lfbpL7pQ/Lva37UDKBL9nFH5NS0kKxTz3BsKrkmz6ry8pZWq2
	 vcCGtfxmqeLEBCsXl5zT/gBAGAvPWfszDuEa9kL7xeSXmsmALu9SmW67RH9yqvZK09
	 KEOs3zgz97YFc4ieuqrxbdpL9STATh9GVf/0VA+4f+ZrjX2GYl4mAPTZaC7fKMd5Tv
	 GBIvWetuVlpCqFCzgDLCIntn+VXI+9mVe3azFPsfxvmIgVm+7Oh54tdOiieXRNWLJ2
	 uPBNa0b009Lzg==
Message-ID: <d5468dd2-0f81-4d89-a3bd-a546b2395ca6@kernel.org>
Date: Thu, 12 Sep 2024 16:15:56 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] PCI: qcom: Add support to PCIe slot power supplies
To: Qiang Yu <quic_qianyu@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, vkoul@kernel.org,
 kishon@kernel.org, robh@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org,
 quic_msarkar@quicinc.com, quic_devipriy@quicinc.com, kw@linux.com,
 lpieralisi@kernel.org, neil.armstrong@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
 <20240827063631.3932971-9-quic_qianyu@quicinc.com>
 <CAA8EJpq5KergZ8czg4F=EYMLANoOeBsiSVoO-zAgfG0ezQrKCQ@mail.gmail.com>
 <20240827165826.moe6cnemeheos6jn@thinkpad>
 <26f2845f-2e29-4887-9f33-0b5b2a06adb6@quicinc.com>
 <20240911153228.7ajcqicxnu2afhbp@thinkpad>
 <9222ef18-2eef-4ba3-95aa-fae540c06925@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <9222ef18-2eef-4ba3-95aa-fae540c06925@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.09.2024 3:39 PM, Qiang Yu wrote:
> 
> On 9/11/2024 11:32 PM, Manivannan Sadhasivam wrote:
>> On Wed, Sep 11, 2024 at 04:17:41PM +0800, Qiang Yu wrote:
>>> On 8/28/2024 12:58 AM, Manivannan Sadhasivam wrote:
>>>> On Tue, Aug 27, 2024 at 02:44:09PM +0300, Dmitry Baryshkov wrote:
>>>>> On Tue, 27 Aug 2024 at 09:36, Qiang Yu <quic_qianyu@quicinc.com> wrote:
>>>>>> On platform x1e80100 QCP, PCIe3 is a standard x8 form factor. Hence, add
>>>>>> support to use 3.3v, 3.3v aux and 12v regulators.
>>>>> First of all, I don't see corresponding bindings change.
>>>>>
>>>>> Second, these supplies power up the slot, not the host controller
>>>>> itself. As such these supplies do not belong to the host controller
>>>>> entry. Please consider using the pwrseq framework instead.
>>>>>
>>>> Indeed. For legacy reasons, slot power supplies were populated in the host
>>>> bridge node itself until recently Rob started objecting it [1]. And it makes
>>>> real sense to put these supplies in the root port node and handle them in the
>>>> relevant driver.
>>>>
>>>> I'm still evaluating whether the handling should be done in the portdrv or
>>>> pwrctl driver, but haven't reached the conclusion. Pwrctl seems to be the ideal
>>>> choice, but I see a few issues related to handling the OF node for the root
>>>> port.
>>>>
>>>> Hope I'll come to a conclusion in the next few days and will update this thread.
>>>>
>>>> - Mani
>>>>
>>>> [1] https://lore.kernel.org/lkml/20240604235806.GA1903493-robh@kernel.org/
>>> Hi Mani, do you have any updates?
>>>
>> I'm working with Bartosz to add a new pwrctl driver for rootports. And we are
>> debugging an issue currently. Unfortunately, the progress is very slow as I'm on
>> vacation still.
>>
>> Will post the patches once it got resolved.
>>
>> - Mani
> OK, thanks for your update.

Qiang, you can still resubmit the rest of the patches without having
to wait on that to be resolved

Konrad

