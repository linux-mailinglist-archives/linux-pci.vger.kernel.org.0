Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E33857C909
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 12:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiGUKdG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 06:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiGUKdF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 06:33:05 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E325D125;
        Thu, 21 Jul 2022 03:33:04 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 26LAWtEB015258;
        Thu, 21 Jul 2022 05:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1658399575;
        bh=i72ix9/vLqj3WlysQhcHY9hq3MwM1JTvuoM8AC2CyM8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=licGoNO1ElXIw89rsaC2Jss8iyZQghm7esEoWwd7rupH9eEVd0EnYM1c6d6CP/PdH
         21KuTG3jg407vMjUv1ZUiuI5h7twWZni1RKLPNsYKYhJEDTXF2d+AQwCVYu6YO4RE0
         eL8SXgxyQaIkhM/vOlN/MpxTQqXSpThv0J0Ypqpk=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 26LAWtMc059112
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Jul 2022 05:32:55 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 21
 Jul 2022 05:32:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 21 Jul 2022 05:32:55 -0500
Received: from [172.24.145.247] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 26LAWr0R105234;
        Thu, 21 Jul 2022 05:32:54 -0500
Message-ID: <ff345fdf-4398-0275-1e1d-f87e15b31d3a@ti.com>
Date:   Thu, 21 Jul 2022 16:02:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: No controller seen in /sys/kernel/config/pci_ep/controllers
Content-Language: en-US
To:     Ajay Garg <ajaygargnsit@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <CAHP4M8VuX6NrqyKQU1KS3DdTzZRQTdPK+nF0-eXXeQqhHyOypw@mail.gmail.com>
 <20220713181805.GA841376@bhelgaas>
 <CAHP4M8X67WSLMqe2qQrbODrg5oSLvR5fP4JVN+zeQafHizrOXA@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
In-Reply-To: <CAHP4M8X67WSLMqe2qQrbODrg5oSLvR5fP4JVN+zeQafHizrOXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 21/07/22 15:54, Ajay Garg wrote:
> Any pointers please?
> 
> Thanks and Regards,
> Ajay
> 
> On Wed, Jul 13, 2022 at 11:48 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> [+to Kishon, endpoint maintainer, +cc LKML]
>>
>> On Wed, Jul 13, 2022 at 12:53:06PM +0530, Ajay Garg wrote:
>>> Hello everyone.
>>>
>>> The kernel has been built with :
>>>
>>> ###################################
>>> CONFIG_PCI_ENDPOINT=y
>>> CONFIG_PCI_ENDPOINT_CONFIGFS=y
>>> CONFIG_PCI_EPF_TEST=y
>>> CONFIG_PCI_ENDPOINT_TEST=y
>>> ###################################
>>>
>>>
>>> Thereafter, following are seen :
>>>
>>> ###################################
>>> $ sudo mount none /sys/kernel/config/ -t configfs
>>> mount: /sys/kernel/config: none already mounted or mount point busy.
>>>
>>> $ ls -lrth /sys/class/pci_epc/
>>> total 0
>>>
>>> $ ls -lrth /sys/kernel/config
>>> total 0
>>> drwxr-xr-x 4 root root 0 Jul 13 10:58 pci_ep
>>> drwxr-xr-x 2 root root 0 Jul 13 10:58 usb_gadget
>>>
>>> $ ls -lrth /sys/kernel/config/pci_ep/functions
>>> total 0
>>> drwxr-xr-x 2 root root 0 Jul 13 10:58 pci_epf_test
>>>
>>> $ ls -lrth /sys/kernel/config/pci_ep/controllers
>>> total 0
>>>
>>> $
>>> ###################################
>>>
>>> What is being missed?
>>>
>>> Side Queries : Is the controller that is expected to be listed, a
>>> virtual-controller (like the one provided by CONFIG_USB_DUMMY_HCD in
>>> case of USB)?

There are no virtual PCIe endpoint controllers in Linux.
>>>
>>> Or there must be a real additional controller for pci-endpoint purpose?

right, there should be an endpoint controller and the driver for it
should register with the Linux endpoint framework.
>>> If yes, then :
>>>
>>>               * I guess no listing is expected currently, as my machine has just
>>>                 one controller (as pci-host).

correct.
>>>
>>>               * Is there a way to have an additional virtual pci-controller?

Not sure what exactly your use case is. All it's going to need is the
driver to use devm_pci_epc_create() to register a endpoint controller.

You can refer existing endpoint controller drivers
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/cadence/pcie-cadence-ep.c
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-designware-ep.c

Thanks,
Kishon
