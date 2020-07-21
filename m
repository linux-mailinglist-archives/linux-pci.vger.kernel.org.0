Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A45522885B
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jul 2020 20:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgGUSg7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 14:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgGUSg7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 14:36:59 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A22C061794;
        Tue, 21 Jul 2020 11:36:58 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z6so5009267iow.6;
        Tue, 21 Jul 2020 11:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DKoqtLlCZ3xb5WBePvpj1u1JNUm5TcuvXGpT5UK2G08=;
        b=OGNxulUtSF4ynIewzetTCPyyWNFlPsCe/npBc9CT8DR+dc8tQKgB+dM+rrnpvXoDnE
         tAKKO+yh/JDOdiRKRHmCjV3Q39ZDOOhUCo7ugO+S10btdbBXNVF0i6tLFrk3MEdc2xuv
         L4S5PHK7EZFjh710wkrvs4I/7qx7H+/0EvGfSNLXx7IsOtlcvEplkKFtx9K8wieQA31F
         aRQ0QITJHNeV72WeeVcCRdy4jYTWS4aovMQYVlv5Hwh24KwYjBug493ROJpaXi2IN5Hb
         qc+3pSeZUR5+9uFQQsOTcYn8FWvhe6vFahthIufPxCPhaPbONEMAhhc7zmrWEF4LGs06
         k+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=DKoqtLlCZ3xb5WBePvpj1u1JNUm5TcuvXGpT5UK2G08=;
        b=G5CiknatQwT/SIc4Xfh1hege6XirFpLgX7rh6LCcdkGP72yBD+q8hcw9TBKoykYEG7
         TsiMDT3mldEutmixcnb5I8cEzeNF7NOCh3TeLB0SIQ9wdsFfCU2NVhG8MAMzDCNaD5UN
         aFeCtj/6+3fXjQNoLefLqFgcVwN/s5pMeVlbcceHxzTStMy2Q8B6EvzCFbEfK6TTSQUF
         ZXSVFnysSQetYDToMe/hyd/cUC6L+Og0MA+V+eZRUS7AIovCoTMIB3/NqR6+F55/Uu1g
         5TQVfjuLn26V3ymOa+CIiy1df1UR+HKVkE5gejNNGfICn6xnTjs04j6LAa8Sq5AFXJoS
         Q4ig==
X-Gm-Message-State: AOAM533SJgWj4cCxV2ok8i/UF1Z8etk0Yr/P4Lnu9qhtuPQffbQn+r9T
        jXqoDeWL0i81ajjwvdz/zuI=
X-Google-Smtp-Source: ABdhPJyjm3x7B2weH8RJQpPYu2oZG841KdnHRI51EDjG4coHaalocFrLEryqkmen2USsZ0klb87UgA==
X-Received: by 2002:a6b:b555:: with SMTP id e82mr28464431iof.56.1595356617867;
        Tue, 21 Jul 2020 11:36:57 -0700 (PDT)
Received: from hive64.slackware.lan (SEB-ai06-18-141.wcta.net. [64.110.18.141])
        by smtp.gmail.com with ESMTPSA id u3sm10795893iol.41.2020.07.21.11.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 11:36:57 -0700 (PDT)
Subject: Re: nouveau regression with 5.7 caused by "PCI/PM: Assume ports
 without DLL Link Active train links in 100 ms"
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>
Cc:     Karol Herbst <kherbst@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Sasha Levin <sashal@kernel.org>
References: <CACO55tuA+XMgv=GREf178NzTLTHri4kyD5mJjKuDpKxExauvVg@mail.gmail.com>
 <20200716235440.GA675421@bjorn-Precision-5520>
 <CACO55tuVJHjEbsW657ToczN++_iehXA8pimPAkzc=NOnx4Ztnw@mail.gmail.com>
 <CACO55tso5SVipAR=AZfqhp6GGkKO9angv6f+nd61wvgAJtrOKg@mail.gmail.com>
 <20200721122247.GI5180@lahna.fi.intel.com>
 <f951fba07ca7fa2fdfd590cd5023d1b31f515fa2.camel@redhat.com>
 <20200721152737.GS5180@lahna.fi.intel.com>
From:   Patrick Volkerding <volkerdi@gmail.com>
Autocrypt: addr=volkerdi@gmail.com; prefer-encrypt=mutual; keydata=
 mQGiBD5dIFQRBADB31WinbXdaGk/8RNkpnZclu1w3Xmd5ItACDLB2FhOhArw35EAMOYzxI0g
 RtDNWN4pn9n74q4HbFzyRWElThWRtBTYLEpImzrk7HYVCjMxjw5A0fTr88aiHOth5aS0vPAo
 q+3TYn6JDSipf2bR03G2JVwgj3Iu066pX4naivNm8wCgldHGF3y9vT3UPYh3QFgEUlCalt0D
 /3n6NopRYy0hMN6BPu+NarXwv6NQ9g0GV5FNjEErigkrD/htqCyWAUl8zyCKKUFZZx4UGBRZ
 5guCdNzwgYH3yn3aVMhJYQ6tcSlLsj3fJIz4LAZ3+rI77rbn7gHHdp7CSAuV+QHv3aNanUD/
 KGz5SPSvF4w+5qRM4PfPNT1hLMV8BACzxiyX7vzeE4ZxNYvcuCtv0mvEHl9yD66NFA35RvXa
 O0QiRVYeoUa5JOQZgwq+fIB0zgsEYDhXFkC1hM/QL4NccMRk8C09nFn4eiz4dAEnwKt4rLCJ
 KhkLl1DWTSoXHe/dOXaLnFyLzB1J8hEYmUvw3SwPt//wMqDiVBLeZfFcdLQwU2xhY2t3YXJl
 IExpbnV4IFByb2plY3QgPHNlY3VyaXR5QHNsYWNrd2FyZS5jb20+iF8EExECAB8ECwcDAgMV
 AgMDFgIBAh4BAheABQJQPlypBQlBo7MrAAoJEGpEY8BAECIzjOwAn3vptb6K1v2wLI9eVlnC
 dx4m1btpAJ9sFt4KwJrEdiO5wFC4xe9G4eZl4rkBDQQ+XSBVEAQA3VYlpPyRKdOKoM6t1SwN
 G0YgVFSvxy/eiratBf7misDBsJeH86Pf8H9OfVHOcqscLiC+iqvDgqeTUX9vASjlnvcoS/3H
 5TDPlxiifIDggqd2euNtJ8+lyXRBV6yPsBIA6zki9cR4zphe48hKpSsDfj7uL5sfyc2UmKKb
 oSu3x7cAAwUD/1jmoLQs9bItbTosoy+5+Uzrl0ShRlv+iZV8RPzAMFuRJNxUJkUmmThowtXR
 aPKFI9AVd+pP44aAJ+zxCPtS2isiW20AxubJoBPpXcVatJWi4sG+TM5Z5VRoLg7tIDNVWsyH
 GXPAhIG2Y8Z1kyWwb4P8A/W2b1ZCqS7Fx4yEhTikiEwEGBECAAwFAlA+XL8FCUGjs2IACgkQ
 akRjwEAQIjMsbQCgk59KFTbTlZfJ6FoZjjEmK3/xGR4AniYT+EdSdvEyRtZYkqWzp1ayvO1b
Message-ID: <d3253a47-09ff-8bc7-3ca1-a80bdc09d1c2@gmail.com>
Date:   Tue, 21 Jul 2020 13:37:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721152737.GS5180@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/21/20 10:27 AM, Mika Westerberg wrote:
> On Tue, Jul 21, 2020 at 11:01:55AM -0400, Lyude Paul wrote:
>> Sure thing. Also, feel free to let me know if you'd like access to one of the
>> systems we saw breaking with this patch - I'm fairly sure I've got one of them
>> locally at my apartment and don't mind setting up AMT/KVM/SSH
> Probably no need for remote access (thanks for the offer, though). I
> attached a test patch to the bug report:
>
>   https://bugzilla.kernel.org/show_bug.cgi?id=208597
>
> that tries to work it around (based on the ->pm_cap == 0). I wonder if
> anyone would have time to try it out.


Hi Mika,

I can confirm that this patch applied to 5.4.52 fixes the issue with
hybrid graphics on the Thinkpad X1 Extreme gen2.

Thanks,

Pat

