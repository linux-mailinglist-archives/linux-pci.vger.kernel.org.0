Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2C831A5325
	for <lists+linux-pci@lfdr.de>; Sat, 11 Apr 2020 19:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgDKR2Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Apr 2020 13:28:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35621 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgDKR2P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Apr 2020 13:28:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id r26so5790477wmh.0;
        Sat, 11 Apr 2020 10:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c+8X1vIVLRV5LUWN9h/LUA7Hybfh7nZjXZqWThPNSJ4=;
        b=MXSvsu0+/ALU1ueAVvC/LhEaJqD5DalB/kFVPE8HmhE/p4orlxNbTwoFpsp9yR1osi
         KNR1CLf5TBJwHE9UUvTVpmvryZbTDJ9lKBTQsajeRzKNQkgTsXVA7NzTd/Vejc+896qQ
         aZEIl2w4/+LcfhJCXuY7XHTcQcZbGpLPZ0xLPV142FxgzNFwz4XyxGT8T80+xpjLi6Cl
         axtVqlZTYxJJC3MPS/VqubD4niVAAFBakCbL7jZjpYOl6rgIHUsBizPhcl8sn4hgO8uR
         1sVQMu46eVbZOldL/VxE4zun8ulBZrgg8Nh4whREpVafWY8sR1cblL01BLS8ts9ZiOR9
         HmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c+8X1vIVLRV5LUWN9h/LUA7Hybfh7nZjXZqWThPNSJ4=;
        b=P7QXkKE1wDwsqb8EdBp8cxJG6ResfbO+K2vtirFIJDYsiRm9GVuatGIGDR8lYR8YMn
         2S3Ri2H/cTx6Uy8q7j16DmqEjIxEidy8gpxmDlMZEgNNbK/31dJta5iJVBnRSTPbMtwi
         +3kjYNTQ8RRPEC4HOwVA9E8htjzaJJYhlBwsoWwcIOlUxVgkMB1wQ6VaM1Tl86NvHV/W
         jPEho5iocg6tUMtW623vzn+1cA+27ZgiGIDnJ3CBfzgMSBUtUo8cvi67ua/45/Uc4ak0
         dm2elnnO5xoUFuWqn+rL0qw8AdL/hxgCn8NkJseawDDkfVw6OH8zXM5js7Rmp8sfl13s
         X4RQ==
X-Gm-Message-State: AGi0PuatMXWFanAMODdN3CuP00a0rM5ZQr8BloEM8OPTDKlxZK/Jezxl
        qAsac4eaD429Xr/Mg/j900gb8PaN
X-Google-Smtp-Source: APiQypLEnPgmwf+KZxltRpfshvuG996TQC9RSfUs4U8VuOZAj7T+DSa4Mxw1szI6qcp2CXojbzKxSA==
X-Received: by 2002:a1c:b356:: with SMTP id c83mr11257579wmf.10.1586626092761;
        Sat, 11 Apr 2020 10:28:12 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id s9sm10081534wmc.2.2020.04.11.10.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2020 10:28:11 -0700 (PDT)
Subject: Re: [RFC PATCH] PCI: rcar: Fix incorrect programming of OB windows
To:     Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20191004132941.6660-1-andrew.murray@arm.com>
 <20191216120607.GV24359@e119886-lin.cambridge.arm.com>
 <0e6e7353-c92b-d819-771b-f9b58684a3d4@gmail.com>
 <20200208184147.GC19388@big-machine>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <f6472d4b-83fa-abdf-cbf7-205ab55f1e66@gmail.com>
Date:   Sat, 11 Apr 2020 19:27:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200208184147.GC19388@big-machine>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/8/20 7:41 PM, Andrew Murray wrote:
> On Sat, Feb 08, 2020 at 10:46:25AM +0100, Marek Vasut wrote:
>> On 12/16/19 1:06 PM, Andrew Murray wrote:
>>> On Fri, Oct 04, 2019 at 02:29:41PM +0100, Andrew Murray wrote:
>>>> The outbound windows (PCIEPAUR(x), PCIEPALR(x)) describe a mapping between
>>>> a CPU address (which is determined by the window number 'x') and a
>>>> programmed PCI address - Thus allowing the controller to translate CPU
>>>> accesses into PCI accesses.
>>>>
>>>> However the existing code incorrectly writes the CPU address - lets fix
>>>> this by writing the PCI address instead.
>>>>
>>>> For memory transactions, existing DT users describe a 1:1 identity mapping
>>>> and thus this change should have no effect. However the same isn't true for
>>>> I/O.
>>>>
>>>> Fixes: c25da4778803 ("PCI: rcar: Add Renesas R-Car PCIe driver")
>>>> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
>>>>
>>>> ---
>>>> This hasn't been tested, so keen for someone to give it a try.
>>>>
>>>> Also keen for someone to confirm my understanding that the RCar windows
>>>> expect PCI addresses and that res->start refers to CPU addresses. If this
>>>> is correct then it's possible the I/O doesn't work correctly.
>>>
>>> Marek/Yoshihiro - any feedback on this?
>>
>> It does indeed look correct,
>> Reviewed-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>
>> # On R8A77951 Salvator-XS with Intel 8086:f1a5 600P SSD
>> # On R8A77965 Salvator-XS with Intel 8086:10d3 82574L NIC
>> Tested-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Thanks for testing - much appreciated!
> 
> Andrew Murray

Can this be applied then ?
