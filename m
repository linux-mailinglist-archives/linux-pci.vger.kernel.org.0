Return-Path: <linux-pci+bounces-74-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BB37F3AA8
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 01:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37A41C20DFE
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 00:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D288188;
	Wed, 22 Nov 2023 00:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="TZnrtc+8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140139D
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 16:25:52 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3316c6e299eso2777193f8f.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 16:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700612750; x=1701217550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s7WvR4k8Gq2Hu8nqgIQzq9lzZsEdGxc47IAScH7UykY=;
        b=TZnrtc+85qahOMGuy8q0MabkPAXiFQl0uH7AMxPn/z43a443XVuxhjDSHnYfkPi8Tf
         LVnOT1hnOP+Hg/0uMvCnet7dXPvUKIbde+tPhWZJUXEO9XxIPms4ErffHDr3dPzSvgym
         EAaAevTFBdxNzdDtxPX68oMuUI5DM/vj7d3HRqJMqA4e32k6dScEUhvUQD6AmaequHxI
         0EeX2ZkLQtwdrnlXXu8LrlL5pBzxnAB9svBZxa0lWaaBhiAtrVAZuAS2N0kdV6uyLQgu
         MUyEuibBTAq8XP1ZNFOJ6djccxPnUrfg6spZ32HDvF7kLK6TT6MFj2aqD+B04HX8Hjsi
         zkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700612750; x=1701217550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s7WvR4k8Gq2Hu8nqgIQzq9lzZsEdGxc47IAScH7UykY=;
        b=hHQE00t3HQj3ZJXeIZ7SvLCg0WgksoQEvSDQmRDGN2pcHf6Lpu2tW4v0LB7aydRntM
         FLQATOUtgWAfNG1aotkL71h0xgxjmOI7cmaDJJGtr56FxhqzFMTOC7wl3qTfX6YivSC/
         Bcyrl5OlgNqfyamY/2c1SHSh1EBJd12Aq91oku6klBdnDYANV3zQ3Gwvg18fv0vLzeNF
         MUbSqINecqhaU2SaJPHDUrsnt/TCMKmZo/EIEWwWmcsXA2ugIb3GZnewKYXqo+9lLw9Q
         X6eLSJZf+SGHO8gDkDIzOMPpBlUmZnNZHx0tHC0tmbIL6sqF/Z7yCsuUGu2osP5NXSzX
         8T3w==
X-Gm-Message-State: AOJu0YyJrRtDU5os3xfaSztxpVEGwoxGNO6ZXPe04NQMcA4CMFWmZbGo
	KFQjYe8sG7Sv4h2wozi7jEOM8A==
X-Google-Smtp-Source: AGHT+IE1Fci+wSwRGIPa4owgPSJMzZxkDaxLdnUE12Q1GY6yso2esB5zU3MTvq/GzoQrzzf8NBktFw==
X-Received: by 2002:a5d:648c:0:b0:332:d152:5e9b with SMTP id o12-20020a5d648c000000b00332d1525e9bmr370557wri.57.1700612750457;
        Tue, 21 Nov 2023 16:25:50 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t16-20020a05600c199000b0040b1a3c83b6sm294209wmq.40.2023.11.21.16.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 16:25:49 -0800 (PST)
Message-ID: <eb27909b-931e-406e-a77d-b77f7305b532@arista.com>
Date: Wed, 22 Nov 2023 00:25:48 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] switchtec: Fix stdev_release crash after suprise
 device loss.
To: Bjorn Helgaas <helgaas@kernel.org>, Daniel Stodden <dns@arista.com>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org
References: <20231122001922.GA264028@bhelgaas>
Content-Language: en-US
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <20231122001922.GA264028@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

HI Bjorn,

On 11/22/23 00:19, Bjorn Helgaas wrote:
> On Tue, Nov 21, 2023 at 03:58:22PM -0800, Daniel Stodden wrote:
>>> On Nov 21, 2023, at 10:40 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> On Tue, Nov 21, 2023 at 10:23:51AM -0800, Daniel Stodden wrote:
>>>>> On Nov 20, 2023, at 1:25 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>> On Mon, Nov 13, 2023 at 01:21:50PM -0800, Daniel Stodden wrote:
>>>>>> A pci device hot removal may occur while stdev->cdev is held open. The
>>>>>> call to stdev_release is then delivered during close or exit, at a
>>>>>> point way past switchtec_pci_remove. Otherwise the last ref would
>>>>>> vanish with the trailing put_device, just before return.
>>>>>>
>>>>>> At that later point in time, the device layer has alreay removed
>>>>>> stdev->mrpc_mmio map. Also, the stdev->pdev reference was not a
>>>>>
>>>>> I guess this should say the "stdev->mmio_mrpc" (not "mrpc_mmio")?
>>>>
>>>> Eww. My fault. Could you still correct that?
>>>
>>> Yep, I speculatively made that change already, so thanks for
>>> confirming it :)
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=switchtec&id=f9724598e29d
>>
>> Thanks. And sorry for what’s next. 
>>
>> Look what I just found in my internal review inbox.
>>
>> Signed-off/Reviewed-by: dima@arista.com
> 
> Happy to add that, no problem, but:
> 
>   - "Signed-off-by" has a specific meaning about either being involved
>     in the creation of the patch or being part of the chain of
>     transmitting the patch, see
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.6#n396
>     Since I got the patch directly from you, adding a signed-off-by
>     from dima@ would mean he created part of the patch.
> 
>   - I don't think it makes sense to include both Signed-off-by and
>     Reviewed-by from the same person, since the point of Reviewed-by
>     is to get review by somebody other than the author.
> 
>   - dima@ should include a name as well as the email address (I assume
>     "Dmitry Safonov <dima@arista.com>")
> 
> So if you want to use a Signed-off-by from Dmitry, please post a v4
> including that (ideally starting from the commit above because I
> silently fixed a couple other typos (although I missed the
> put_device() thing)).
> 
> If you prefer a Dmitry's Reviewed-by, no need to post a v4.  The best
> thing would be for Dmitry to respond with the Reviewed-by on the
> mailing list.  Some people do collect reviews internally, but I prefer
> to get them directly from the reviewer.

It's fine to drop my SoB. With the fixup above,

Reviewed-by: Dmitry Safonov <dima@arista.com>

Thanks,
            Dmitry


