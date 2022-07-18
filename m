Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B9B577CC0
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 09:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiGRHoH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 03:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiGRHoE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 03:44:04 -0400
Received: from extserv.mm-sol.com (ns.mm-sol.com [37.157.136.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9796F63D6;
        Mon, 18 Jul 2022 00:44:02 -0700 (PDT)
Received: from [192.168.1.7] (unknown [195.24.90.54])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: svarbanov@mm-sol.com)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id AB337D2E3;
        Mon, 18 Jul 2022 10:43:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1658130239; bh=J2XEYZ7B+4jlGgZLIA7nxTffPaKXrEtUOke3dtH0o4A=;
        h=Date:Subject:To:Cc:From:From;
        b=UEHMbqGc0/Xd6wlIuArKJOYm3ei7nKsevKujc2jIU/mFOBjf9hF1ynuSvp4CjcONC
         qAMxNBLzYcos6Xaihx16T6tWqdgpUZykNLZDtNQ+3Eqzy2o3l4nLWnSVQc8dbVVL4d
         N7HKi3tt6TRePbksPwWmqH+VxUXSE5F9YCExEHRY2+1CkKQwryeK/SH4TKBLCs81Nb
         1bbwkky/euPn3dV320ieaaqH1+OLi4/BoSW2CaBIOCac85vqngTy4gFJS0FcVrHpc/
         YaOwJg0ri+E0/rHEfXbXW1Xskq697oqDGxDw5d1qsX5NiGZnA9dYopF/+fjiTQwtZy
         BmJSZRJ3tm/kQ==
Message-ID: <d6db1784-0b21-9bdb-8528-3f814da188b0@mm-sol.com>
Date:   Mon, 18 Jul 2022 10:43:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] PCI: qcom: Add support for modular builds
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220715165601.GA1139849@bhelgaas>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
In-Reply-To: <20220715165601.GA1139849@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/15/22 19:56, Bjorn Helgaas wrote:
> On Thu, Jul 14, 2022 at 04:05:41PM +0300, Dmitry Baryshkov wrote:
>> On 14/07/2022 15:19, Stanimir Varbanov wrote:
>>> Please take a look why we made it built-in first [1].
>>>
>>> If arguments there are still valid I don't see why to make it a module
>>> again.
>>>
>>> [1] https://lkml.org/lkml/2016/8/24/694
>>
>> It looks like there is a move to make all non-essential drivers buildable as
>> modules. For example, the Kirin, dra7xx, Meson PCI controllers are now
>> buildable as modules. So I think we can follow that and allow building the
>> pcie-qcom as a module.
> 
> IIUC the arguments in [1] are that:
> 
>   - Kconfig is bool, so it can't be built as a module
>   - there's no sensible use case for unbind
> 
> Those described the situation at the time, and there's no point in
> having .remove() and using module_platform_driver() if Kconfig is
> bool.
> 
> But they don't seem like arguments for why the driver couldn't be
> *made* modular.

I guess the core of the problem was lack of dw_pcie_host_deinit() at
that time.
> 
> I think drivers *should* be modular unless there's a technical reason
> they can't be.

I agree.

> 
> Bjorn

-- 
regards,
Stan
