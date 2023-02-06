Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1C968C575
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 19:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBFSMC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 13:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjBFSLp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 13:11:45 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E14740FA;
        Mon,  6 Feb 2023 10:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675707105; x=1707243105;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UXKk67sn1KzwtJdfACtz/yZko3ihaRX+Ewb0PlQhwmg=;
  b=c3xOpzzoNr+Z4GyUD/DUd3JxzLAOBsDfIXe/udskaPnN5Hx7uyRsuYX6
   GTJmKz1vneRFLfFzWbDXpfIdbRn9C12cTOXZMguU5OxsRq7dRS19/VmSq
   0QMkBMu5xvwlYy4yPaVOgc2jcpg5nuLs6mz34OYhGnW/mt9qfckOJ/oQ8
   Ck0PvIURuXeT+PqKpIbBkSbhXKVdrjqyhPpjpiwmwyByYAXz0yjK8ROdF
   XSj7tQyVbrc/ABlDOaa5zSO1frVojJkWMSP/qMhkf++6Kljd59whAO/Rf
   HysI3dAYFE2Xy68Mxvh/pOrHxIRO14HhHeLwZlE7T83DWZ5NmB4kHVlxc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="327909613"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="327909613"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 10:11:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="659928360"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="659928360"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.78.16.176]) ([10.78.16.176])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 10:11:43 -0800
Message-ID: <9e6cfda1-4309-d1bb-a0cf-404a7fe7d3aa@linux.intel.com>
Date:   Mon, 6 Feb 2023 11:11:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] PCI: vmd: Do not disable MSI-X remapping in VMD 28C0
 controller
Content-Language: en-US
To:     Xinghui Li <korantwork@gmail.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     Keith Busch <kbusch@kernel.org>, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
References: <20221222072603.1175248-1-korantwork@gmail.com>
 <3d1834d9-7905-1225-741a-f298dd5b8a8e@linux.dev>
 <Y6TSgGdCTvkwPiVg@kbusch-mbp.dhcp.thefacebook.com>
 <CAEm4hYUWf+Fx3FV7vNTc8+O9NSb0iQp75MTC6gra6XapXK=cxw@mail.gmail.com>
 <d14ac29d-027a-08a7-c5c8-848a6920d4a2@linux.dev>
 <CAEm4hYXncuvL-Gk1aEZExrvkbx=N1aiOQNeNjFdB4443EbKNBA@mail.gmail.com>
 <f05ee82a-4532-b12b-490f-904b946ff7b0@linux.dev>
 <CAEm4hYXk1RuKEw41VukH2iGTo_9GmZjUfrESWK5vFtpFA_O_4A@mail.gmail.com>
 <CAEm4hYWeZFrYxSvAcBJ8iw=t507vZMqfBwiQXFSJd2Hcyfw7fA@mail.gmail.com>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <CAEm4hYWeZFrYxSvAcBJ8iw=t507vZMqfBwiQXFSJd2Hcyfw7fA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/6/2023 5:45 AM, Xinghui Li wrote:
> Friendly ping~
>
> Xinghui Li <korantwork@gmail.com> 于2023年1月10日周二 20:28写道：
>> Jonathan Derrick <jonathan.derrick@linux.dev> 于2023年1月10日周二 05:00写道：
>>> As the bypass mode seems to affect performance greatly depending on the specific configuration,
>>> it may make sense to use a moduleparam to control it
>>>
>> We found that each pcie port can mount four drives. If we only test 2
>> or 1 dirve of one pcie port,
>> the performance of the drive performance will be normal. Also, we
>> observed the interruptions in different modes.
>> bypass:
>> .....
>> 2022-12-28-11-39-14: 1224       181665   IR-PCI-MSI 201850948-edge      nvme0q68
>> 2022-12-28-11-39-14: 1179       180115   IR-PCI-MSI 201850945-edge      nvme0q65
>> 2022-12-28-11-39-14:  RES        26743   Rescheduling interrupts
>> 2022-12-28-11-39-17: irqtop - IRQ : 3029, TOTAL : 2100315228, CPU :
>> 192, ACTIVE CPU : 192
>> disable:
>> ......
>> 2022-12-28-12-05-56: 1714       169797   IR-PCI-MSI 14155850-edge      nvme1q74
>> 2022-12-28-12-05-56: 1701       168753   IR-PCI-MSI 14155849-edge      nvme1q73
>> 2022-12-28-12-05-56:  LOC       163697   Local timer interrupts
>> 2022-12-28-12-05-56:  TLB         5465   TLB shootdowns
>> 2022-12-28-12-06-00: irqtop - IRQ : 3029, TOTAL : 2179022106, CPU :
>> 192, ACTIVE CPU : 192
>> remapping:
>> 022-12-28-11-25-38:  283       325568   IR-PCI-MSI 24651790-edge      vmd3
>> 2022-12-28-11-25-38:  140       267899   IR-PCI-MSI 13117447-edge      vmd1
>> 2022-12-28-11-25-38:  183       265978   IR-PCI-MSI 13117490-edge      vmd1
>> ......
>> 2022-12-28-11-25-42: irqtop - IRQ : 2109, TOTAL : 2377172002, CPU :
>> 192, ACTIVE CPU : 192
>>
>> From the result it is not difficult to find, in remapping mode the
>> interruptions come from vmd.
>> While in other modes, interrupts come from nvme devices. Besides, we
>> found the port mounting
>> 4 dirves total interruptions is much fewer than the port mounting 2 or 1 drive.
>> NVME 8 and 9 mount in one port, other port mount 4 dirves.
>>
>> 2022-12-28-11-39-14: 2582       494635   IR-PCI-MSI 470810698-edge      nvme9q74
>> 2022-12-28-11-39-14: 2579       489972   IR-PCI-MSI 470810697-edge      nvme9q73
>> 2022-12-28-11-39-14: 2573       480024   IR-PCI-MSI 470810695-edge      nvme9q71
>> 2022-12-28-11-39-14: 2544       312967   IR-PCI-MSI 470286401-edge      nvme8q65
>> 2022-12-28-11-39-14: 2556       312229   IR-PCI-MSI 470286405-edge      nvme8q69
>> 2022-12-28-11-39-14: 2547       310013   IR-PCI-MSI 470286402-edge      nvme8q66
>> 2022-12-28-11-39-14: 2550       308993   IR-PCI-MSI 470286403-edge      nvme8q67
>> 2022-12-28-11-39-14: 2559       308794   IR-PCI-MSI 470286406-edge      nvme8q70
>> ......
>> 2022-12-28-11-39-14: 1296       185773   IR-PCI-MSI 202375243-edge      nvme1q75
>> 2022-12-28-11-39-14: 1209       185646   IR-PCI-MSI 201850947-edge      nvme0q67
>> 2022-12-28-11-39-14: 1831       184151   IR-PCI-MSI 203423828-edge      nvme3q84
>> 2022-12-28-11-39-14: 1254       182313   IR-PCI-MSI 201850950-edge      nvme0q70
>> 2022-12-28-11-39-14: 1224       181665   IR-PCI-MSI 201850948-edge      nvme0q68
>> 2022-12-28-11-39-14: 1179       180115   IR-PCI-MSI 201850945-edge      nvme0q65
>>> I'd vote for it being in VMD mode (non-bypass) by default.
>> I speculate that the vmd controller equalizes the interrupt load and
>> acts like a buffer,
>> which improves the performance of nvme. I am not sure about my
>> analysis. So, I'd like
>> to discuss it with the community.

I like the idea of module parameter to allow switching between the modes
but keep MSI remapping enabled (non-bypass) by default.

