Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 493DB1563B3
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2020 10:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgBHJxm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Feb 2020 04:53:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42112 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgBHJxl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Feb 2020 04:53:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id k11so1671562wrd.9;
        Sat, 08 Feb 2020 01:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VyEMVigjKDgm/rEhG178iXCGYu/RDIHlN9vDmAf1Mog=;
        b=ob5uzi7IviB1iOLC7hCFKtUFzF9GnBR3B6BtAcL5NA/SyHYMoyU/XodeSeRuFQMO6B
         AzsFMRN46a2UaOip61IzQBmU9Fa49opGFzt8HxYzCB7zGnn2/yXT+G5Tr/r2LpuQgHi7
         pAnTJvnr8ubvXlUPtkPQx0yK9zSQIboE/8pD34wiuOqWH+v/6jxSxAagkasSmNLfA59/
         KjGxk/LSQbP9fapWW54KJfGFVqK6haFbjPwdRYOFB6mC4boQj3qZi1p/i9NDxeiYqGA9
         C120GZdEU2jIaEbEigafg8d2zgJ8wMkGUUjXTmteBVOjYjnVG90fZ5aKvaIhgUiwvLF1
         rMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VyEMVigjKDgm/rEhG178iXCGYu/RDIHlN9vDmAf1Mog=;
        b=NcWOzKkKJ2cozhg4uv1lcLZ47G1iWKI2oOOKxK+gXpD0S8jmfzss/clfpWtZCDT+LR
         CXJa9JUzHLCV7kdylxCVm3vkaluX9HaKuuxgOCaFBNWIa3/++PjsWzRxjES9X275QzsB
         7P/MDnSoBfDLfNxlKUSSIadOozwcY4RYnJxF1dJGUblf+h2HQJN5PhwENXLd7B5BEPt5
         4fhZQ9hGct6g6L0pOfm7UzEPsDw86ngEWNf97sSgKtD2x2bMS0XYLQrIIWf8wp9HCJfR
         IYMB5PECKerJnBkFxFp6FFeUBJ7keX/5fjnETsUEBG+Ii4sFpdb3eK7w8nvj6K/OCJOP
         W5eQ==
X-Gm-Message-State: APjAAAVsDPfql56UZVJUCW0l8uOttXKfM5/M+eBwq4s4fbYSVZNjpOax
        X3TtqWIVxnoi/u3mdztvbaADO/DX
X-Google-Smtp-Source: APXvYqy5D0i3S3lUnAHXRsA+5MA0mUId6RBStSB4a+vkD3YpPIE7KJqQmMWt52NU50iUc37QKwJUEA==
X-Received: by 2002:a5d:4ac8:: with SMTP id y8mr1733247wrs.272.1581155618900;
        Sat, 08 Feb 2020 01:53:38 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id v15sm391150wrf.7.2020.02.08.01.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2020 01:53:37 -0800 (PST)
Subject: Re: [RFC PATCH] PCI: rcar: Fix incorrect programming of OB windows
To:     Andrew Murray <andrew.murray@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20191004132941.6660-1-andrew.murray@arm.com>
 <20191216120607.GV24359@e119886-lin.cambridge.arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <0e6e7353-c92b-d819-771b-f9b58684a3d4@gmail.com>
Date:   Sat, 8 Feb 2020 10:46:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20191216120607.GV24359@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/16/19 1:06 PM, Andrew Murray wrote:
> On Fri, Oct 04, 2019 at 02:29:41PM +0100, Andrew Murray wrote:
>> The outbound windows (PCIEPAUR(x), PCIEPALR(x)) describe a mapping between
>> a CPU address (which is determined by the window number 'x') and a
>> programmed PCI address - Thus allowing the controller to translate CPU
>> accesses into PCI accesses.
>>
>> However the existing code incorrectly writes the CPU address - lets fix
>> this by writing the PCI address instead.
>>
>> For memory transactions, existing DT users describe a 1:1 identity mapping
>> and thus this change should have no effect. However the same isn't true for
>> I/O.
>>
>> Fixes: c25da4778803 ("PCI: rcar: Add Renesas R-Car PCIe driver")
>> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
>>
>> ---
>> This hasn't been tested, so keen for someone to give it a try.
>>
>> Also keen for someone to confirm my understanding that the RCar windows
>> expect PCI addresses and that res->start refers to CPU addresses. If this
>> is correct then it's possible the I/O doesn't work correctly.
> 
> Marek/Yoshihiro - any feedback on this?

It does indeed look correct,
Reviewed-by: Marek Vasut <marek.vasut+renesas@gmail.com>

# On R8A77951 Salvator-XS with Intel 8086:f1a5 600P SSD
# On R8A77965 Salvator-XS with Intel 8086:10d3 82574L NIC
Tested-by: Marek Vasut <marek.vasut+renesas@gmail.com>
