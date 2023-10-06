Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E517BB6F3
	for <lists+linux-pci@lfdr.de>; Fri,  6 Oct 2023 13:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjJFLve (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Oct 2023 07:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjJFLvd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Oct 2023 07:51:33 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3564BCA
        for <linux-pci@vger.kernel.org>; Fri,  6 Oct 2023 04:51:32 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-692c02adeefso1696954b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 06 Oct 2023 04:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1696593091; x=1697197891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rvlaPDr0ZaJ1x37a2ONF6H4ToXENQDx2tAlrZ4vOKTQ=;
        b=F9IAOAv1dEQPMt17AaKIMdIJstyTYMqRM6WS1md2+vjcEcufmF0zygf3HO3V42eYf4
         Th13BLQh3mXdCM7CpEsjswdYErh7ZML/ZghxvN3xd1GQX1ZgTWh6EMVNSxaPyxUl3683
         kQSeheDV7bzkCBmS7cHB45GHHr2LxgTSMZ8fVxQ2e7FontDqhEVCe54sOzJbBv3vfTjX
         EDdyvQY3cnDGXInNl48qgW00BLNfl6UGPRVQxoNeE3Y+6uQuW2oXq8w7osWBc4QQGwWs
         PpCJvL/fudj2jNGOyXpGhDapknzYgN64+Xi0sM6qreRQLKbw8rQJxo8wbPfqJF1EKmMs
         mhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696593091; x=1697197891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rvlaPDr0ZaJ1x37a2ONF6H4ToXENQDx2tAlrZ4vOKTQ=;
        b=huuLqg82S0zo/UAm0ymJOS0534v68q8CHW/tzOy/soYzs/X3eym8uSjMiBvwKvL0d5
         KBUYwMovTUY3xYzGlFCHjljmsmQMAO+pBqDLqosyOoQShKSUe7Ki0yWaa/1njvAwLZC5
         zPOCY67HMWDMI4B1hUuRQeuLncwYS8wK07or+FGbb4bqvuRemJZK7Cip10PoEMdFw7kj
         /xleVNMvV3JOmm3ti0H2oh/VptK6wapPiVkQBFhp13jbsPGyZn5ADY+9TFhvaLZe1S03
         nQAvU4zSXnvkFodO3lhNc7+LcczpolBipwyNoYkEkvQeH/dQjOqSNdXyeDhaoU6Bx9Uh
         Xo7Q==
X-Gm-Message-State: AOJu0YzSrIkhbE/VbWjdDRkAcQ3saveWQ+xDvg+13hmI+KIgxwS46JQp
        HDc0XhhtG6vHP7Hbc1/awSNXMw==
X-Google-Smtp-Source: AGHT+IFR5hqtYTXozK4kSlJkLHQDyAnNdUmjKDyiuo+Xn23zdFBiJ3GnlASYbFinkoIkYM4FK6OUcw==
X-Received: by 2002:a05:6a20:8419:b0:161:2389:e34b with SMTP id c25-20020a056a20841900b001612389e34bmr9981678pzd.13.1696593091546;
        Fri, 06 Oct 2023 04:51:31 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id u23-20020a62ed17000000b006884844dfcdsm1264512pfh.55.2023.10.06.04.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 04:51:31 -0700 (PDT)
Message-ID: <88775092-78d7-d1b6-100b-369079ff979b@igel.co.jp>
Date:   Fri, 6 Oct 2023 20:51:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC] Proposal of QEMU PCI Endpoint test environment
Content-Language: en-US
To:     Mattias Nissler <mnissler@rivosinc.com>
Cc:     cz172638@gmail.com, bhelgaas@google.com,
        Jagannathan Raman <jag.raman@oracle.com>, kishon@kernel.org,
        kvijayab@amd.com, kw@linux.com, levon@movementarian.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
        robh@kernel.org, thanos.makatos@nutanix.com, vaishnav.a@ti.com,
        william.henderson@nutanix.com
References: <CAGNS4TbhS3XnCFAEi378+cSmJvGMdjN2oTv=tES36vbV4CaDuA@mail.gmail.com>
 <CANXvt5qKxfU3p1eSK4fkzRFRBXHSVvSkJrnQRLKPkQjhsMGNzQ@mail.gmail.com>
 <CAGNS4TbAgqRQepv=fMoUxo02Qea5S9LwWFm-jjt1ej8DdLjshw@mail.gmail.com>
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <CAGNS4TbAgqRQepv=fMoUxo02Qea5S9LwWFm-jjt1ej8DdLjshw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2023/10/05 16:02, Mattias Nissler wrote:
> On Thu, Oct 5, 2023 at 3:31 AM Shunsuke Mie <mie@igel.co.jp> wrote:
>> Hi Jiri, Mattias and all.
>>
>> 2023年10月4日(水) 16:36 Mattias Nissler <mnissler@rivosinc.com>:
>>>> hi shunsuke, all,
>>>> what about vfio-user + qemu?
>> Thank you for the suggestion.
>>
>>> FWIW, I have had some good success using VFIO-user to bridge software components to hardware designs. For the most part, I have been hooking up software endpoint models to hardware design components speaking the PCIe transaction layer protocol. The central piece you need is a way to translate between the VFIO-user protocol and PCIe transaction layer messages, basically converting ECAM accesses, memory accesses (DMA+MMIO), and interrupts between the two worlds. I have some code which implements the basics of that. It's certainly far from complete (TLP is a massive protocol), but it works well enough for me. I believe we should be able to open-source this if there's interest, let me know.
>> It is what I want to do, but I'm not familiar with the vfio and vfio-user, and I have a question. QEMU has a PCI TLP communication implementation for Multi-process QEMU[1]. It is similar to your success.
> I'm no qemu expert, but my understanding is that the plan is for the
> existing multi-process QEMU implementation to eventually be
> superseded/replaced by the VFIO-user based one (qemu folks, please
> correct me if I'm wrong). From a functional perspective they are more
> or less equivalent AFAICT.
>
The project is promising.

I found a session about the vfio adapts to Multi-process QEMU[1] in KVM 
Forun 2021, butI couldn't found some posted patches.
If anyone knows status of this project, could you please let me know?

[1] https://www.youtube.com/watch?v=NBT8rImx3VE
>> The multi-process qemu also communicates TLP over UDS. Could you let me know your opinion about it?
> Note that neither multi-process qemu nor VFIO-user actually pass
> around TLPs, but rather have their own command language to encode
> ECAM, MMIO, DMA, interrupts etc. However, translation from/to TLP is
> possible and works well enough in my experience.
I agree.
>>> One thing to note is that there are currently some limits to bridging VFIO-user / TLP that I haven't figured out and/or will need further work: Advanced PCIe concepts like PASID, ATS/PRI, SR-IOV etc. may lack equivalents on the VFIO-user side that would have to be filled in. The folk behind libvfio-user[2] have been very approachable and open to improvements in my experience though.
>>>
>>> If I understand correctly, the specific goal here is testing PCIe endpoint designs against a Linux host. What you'd need for that is a PCI host controller for the Linux side to talk to and then hooking up endpoints on the transaction layer. QEMU can simulate host controllers that work with existing Linux drivers just fine. Then you can put a vfio-user-pci stub device (I don't think this has landed in qemu yet, but you can find the code at [1]) on the simulated PCI bus which will expose any software interactions with the endpoint as VFIO-user protocol messages over unix domain socket. The piece you need to bring is a VFIO-user server that handles these messages. Its task is basically translating between VFIO-user and TLP and then injecting TLP into your hardware design.
>> Yes, If the pci host controller you said can be implemented, I can achieve my goal.
> I meant to say that the existing PCIe host controller implementations
> in qemu can be used as is.
Sorry, I misunderstood.
>> To begin with, I'll investigate the vfio and libvfio-user.  Thanks!.
>>
>> [1] https://www.qemu.org/docs/master/system/multi-process.html
>>
>> Best,
>> Shunsuke
>>>
>>> [1] https://github.com/oracle/qemu/tree/vfio-user-p3.1 - I believe that's the latest version, Jagannathan Raman will know best
>>> [2] https://github.com/nutanix/libvfio-user
>>>
