Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215E22DAA10
	for <lists+linux-pci@lfdr.de>; Tue, 15 Dec 2020 10:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgLOJ1b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Dec 2020 04:27:31 -0500
Received: from halon.esss.lu.se ([194.47.240.54]:39295 "EHLO halon.esss.lu.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgLOJ1b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Dec 2020 04:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ess.eu; s=dec2019;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:from;
        bh=sdZHHt2k1cjpDg9r8RwbM3XoCJpcbD0iWaqNZIZVAck=;
        b=j9e5nN6W9am0frvQXDQixxrgkBMHkB1hnkXULSNYGPF7CJYdCUZSl7M82BtvluUZQQJwTFJBhmtfa
         SeR3V7ElGqHsCi+vstvvgunQfaENG5RoSifSYdv0i4Udw48ov3yaOAkxbKFebV8Z4pen74zbwDyAKJ
         0g5oKVaj8BLxKLUPYtC+MaDeMqLvmK18ISzESxkc5zoOiLU2de3GAIymcrgVCLmyl7OMN6ccYZQQOe
         CTi0vjX4q4X3ZOddLkPt4dqLpQBHfam2LDHD/u93AZMJ3P3pj5AlWmTrpLgjF5lUmb6SGDmcdALuDa
         4/YH261htZlQApsmeaQQPxirqICkkcg==
Received: from mail.esss.lu.se (it-exch16-4.esss.lu.se [10.0.42.134])
        by halon.esss.lu.se (Halon) with ESMTPS
        id 9ae4fcc0-3eb7-11eb-93c8-005056a66d10;
        Tue, 15 Dec 2020 10:26:26 +0100 (CET)
Received: from [192.168.0.9] (194.47.241.248) by it-exch16-4.esss.lu.se
 (10.0.42.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 15 Dec
 2020 10:25:52 +0100
Subject: Re: Kernel oops while using AER inject
To:     Guilherme Piccoli <gpiccoli@canonical.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <c4bf0e02cd7d4ec49462245a315f882f@ess.eu>
 <CAHD1Q_wQaZOhr6orDP1EE7MuORpbRcUGCmnb4pvL3676BTGpwQ@mail.gmail.com>
From:   Hinko Kocevar <hinko.kocevar@ess.eu>
Message-ID: <33efd075-ae0d-c506-780e-8cb00f149a5a@ess.eu>
Date:   Tue, 15 Dec 2020 10:25:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAHD1Q_wQaZOhr6orDP1EE7MuORpbRcUGCmnb4pvL3676BTGpwQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [194.47.241.248]
X-ClientProxiedBy: IT-Exch16-1.esss.lu.se (10.0.42.131) To
 it-exch16-4.esss.lu.se (10.0.42.134)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/14/20 7:37 PM, Guilherme Piccoli wrote:
> I see you're running a 3.10 modified kernel (Red Hat / CentOS ?) -
> suggest you to try the upstream kernel, if possible. If the error
> persists in the mainline kernel, it's likely you can get more support
> here!
> 

I'm going to use with more recent kernels from 5.9.x series as well as 
Bjorn's git when reporting issues from now on.

Cheers,
//hinko

> Cheers,
> 
> 
> Guilherme
> 
