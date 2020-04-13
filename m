Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF81F1A64C1
	for <lists+linux-pci@lfdr.de>; Mon, 13 Apr 2020 11:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgDMJjw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Apr 2020 05:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728417AbgDMJjr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Apr 2020 05:39:47 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959E7C00860A
        for <linux-pci@vger.kernel.org>; Mon, 13 Apr 2020 02:31:45 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id k28so6046676lfe.10
        for <linux-pci@vger.kernel.org>; Mon, 13 Apr 2020 02:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=22ry+294zZcqaoEVkMcWEawZi6DDugMuA4lCNKrgbiM=;
        b=BWhN9CNUIFwnRIEzUe/BwAX9gwW7YYJZCyOYxczVx74YIU7V0mC7z2OcM35UyP4e1p
         4oOxRRQucYbYOo8AiCmMAGW2yCJUIihy25350/EbU/I375sSwG7o78dsiV8hysjDDbOa
         DCnUiVrCWoS2EZjk23MnwjFyE6krOT3x7Sgxkcs7aHT2ffdKiX8lkj0vMnmWerfoO+2i
         7zWqbpEpLBQKObzkG36N8VsFPvN5FgXPc9jylTJvXndqQyp2RHqSXY8Jmqsv+lNrTK9M
         QWJIsmnIw6LotVNSi1iGc+NY6cZD7jfb5lTAXo0ikhgxxY6x18NMuTetmUhmdg4P5gRK
         IQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=22ry+294zZcqaoEVkMcWEawZi6DDugMuA4lCNKrgbiM=;
        b=XXjQ0Zzu0bxRdZCC3eub0MQM20fBQ+MVsbtfgdKKOgp0eT+57nUhPBz8MzKF6ExuJx
         vRfMv54uVH6vpbNveVryPKMKt94qLlQHB0SQsz1kulH11MN6tEQ34vQxxf7kL4QrCW8V
         DyZ8Q/ld9nQB5JXp5en7ViWXexh719jn+vSN8u+tKDY/1r2pMA2lLcgJP1V9cYIvArLI
         QOlqKrD4zNoK2KeHIimhN4YBO7P2Khv+xIKM0/0obf3Yk4los1LJopyiuCWfZB1+LFby
         re7+qXbKE9WbXSVSIPR8JJHV59Z/JReZ+fc5nPvb3ahbzRlkhQTbE4lR7rx8U3CsN7ra
         R5iw==
X-Gm-Message-State: AGi0Puadg3Y70jg3MvSoRMcWWnB/q8z3/YajoeJ95N8lfPhUxNhHMglk
        bRImGOicf3ItWpFaEvi4ajzctQ==
X-Google-Smtp-Source: APiQypLU2XLKZjsSZmZYU4dGrsmyNyLhGMWhvQXMiwFm5FV0dumbDAT+1S0NQ6VdA0RQSuVQGrkBvQ==
X-Received: by 2002:ac2:4554:: with SMTP id j20mr10171876lfm.91.1586770304122;
        Mon, 13 Apr 2020 02:31:44 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:449a:6c6f:9d43:1ad8:e18f:9ec1? ([2a00:1fa0:449a:6c6f:9d43:1ad8:e18f:9ec1])
        by smtp.gmail.com with ESMTPSA id u1sm6665830ljo.65.2020.04.13.02.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 02:31:43 -0700 (PDT)
Subject: Re: [PATCH v3 1/5] PCI: OF: Don't remap iospace on unsupported
 platform
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200330114239.1112759-1-jiaxun.yang@flygoat.com>
 <20200413053222.3976680-1-jiaxun.yang@flygoat.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <10ef1a19-c2e5-60fc-b3c8-64547017f758@cogentembedded.com>
Date:   Mon, 13 Apr 2020 12:31:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200413053222.3976680-1-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On 13.04.2020 8:32, Jiaxun Yang wrote:

> There are some platforms doesn't support iospace remapping

    That don't support.

> like MIPS. However, our PCI code will try to remap iospace
> unconditionally and reject io resources on these platforms.
> 
> So we should remove iospace remapping check and use a range
> check instead on these platforms.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
[...]

MBR, Sergei
