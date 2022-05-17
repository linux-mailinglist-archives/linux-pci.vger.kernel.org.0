Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4478F529ADD
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 09:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241394AbiEQHdK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 03:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241223AbiEQHdA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 03:33:00 -0400
Received: from hostingweb31-40.netsons.net (hostingweb31-40.netsons.net [89.40.174.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10EC48386;
        Tue, 17 May 2022 00:32:58 -0700 (PDT)
Received: from [77.244.183.192] (port=64646 helo=[192.168.178.75])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1nqrhP-000129-WE; Tue, 17 May 2022 09:32:56 +0200
Message-ID: <ebd3f89b-3487-a610-7583-4ffda01a0dd6@lucaceresoli.net>
Date:   Tue, 17 May 2022 09:32:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] PCI: dra7xx: Fix link removal on probe error
Content-Language: it-IT
To:     Saravana Kannan <saravanak@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, PCI <linux-pci@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sekhar Nori <nsekhar@ti.com>
References: <20211214221450.589884-1-luca@lucaceresoli.net>
 <CAL_Jsq+GQTcx1EGKHug2ZcDZufrKM-4k6PB0vQeTCTG42MHzvA@mail.gmail.com>
 <59a23c89-0810-eb28-acd9-7051ac34d438@lucaceresoli.net>
 <4579940c-27dc-733e-4022-ebea4671c839@lucaceresoli.net>
 <CAL_JsqJ5nr6xJoTv3A6UPMMDXhWKcwSEUA3ux3kK8OMWQxdc6w@mail.gmail.com>
 <YnvnNUrsCOUxMu8A@lpieralisi>
 <615718f9-151e-20fb-fcb0-56063ae61ca6@lucaceresoli.net>
 <CAGETcx9r4e9PkUFNZ+vUfqOSO5=e9apmBj0+DyOkKEvc4CnsLQ@mail.gmail.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
In-Reply-To: <CAGETcx9r4e9PkUFNZ+vUfqOSO5=e9apmBj0+DyOkKEvc4CnsLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Saravana,

On 14/05/22 05:46, Saravana Kannan wrote:
> On Thu, May 12, 2022 at 7:07 AM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>>
>> Hi Lorenzo,
>>
>> On 11/05/22 18:41, Lorenzo Pieralisi wrote:
>>> On Sat, Jan 15, 2022 at 10:02:00AM -0600, Rob Herring wrote:
>>>> +Saravana
>>>>
>>>> On Tue, Jan 11, 2022 at 4:35 AM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>>>>>
>>>>> Hi Rob,
>>>>>
>>>>> On 16/12/21 10:08, Luca Ceresoli wrote:
>>>>>> Hi Rob,
>>>>>>
>>>>>> thanks for the quick feedback!
>>>>>>
>>>>>> On 14/12/21 23:42, Rob Herring wrote:
>>>>>>> On Tue, Dec 14, 2021 at 4:15 PM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>>>>>>>>
>>>>>>>> If a devm_phy_get() calls fails with phy_count==N (N > 0), then N links
>>>>>>>> have already been added by device_link_add() and won't be deleted by
>>>>>>>> device_link_del() because the code calls 'return' and not 'goto err_link'.
>>>>>>>>
>>>>>>>> Fix in a very simple way by doing all the devm_phy_get() calls before all
>>>>>>>> the device_link_add() calls.
>>>>>>>>
>>>>>>>> Fixes: 7a4db656a635 ("PCI: dra7xx: Create functional dependency between PCIe and PHY")
>>>>>>>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>>>>>>>> ---
>>>>>>>>  drivers/pci/controller/dwc/pci-dra7xx.c | 2 ++
>>>>>>>>  1 file changed, 2 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
>>>>>>>> index f7f1490e7beb..2ccc53869e13 100644
>>>>>>>> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
>>>>>>>> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
>>>>>>>> @@ -757,7 +757,9 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
>>>>>>>>                 phy[i] = devm_phy_get(dev, name);
>>>>>>>>                 if (IS_ERR(phy[i]))
>>>>>>>>                         return PTR_ERR(phy[i]);
>>>>>>>> +       }
>>>>>>>>
>>>>>>>> +       for (i = 0; i < phy_count; i++) {
>>>>>>>>                 link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
>>>>>>>
>>>>>>> I think this should happen automatically now with fw_devlink being
>>>>>>> enabled by default. Can you try?
>>>>>>
>>>>>> Do you mean removal should be done automatically? I think they are not
>>>>>> due to the DL_FLAG_STATELESS flag.
>>>>>
>>>>> I would love to have feedback because, as said, I think my patch is
>>>>> correct, but if I'm wrong (which might well be) I have to drop patch 1
>>>>> and rewrite patch 2 in a slightly more complex form.
>>>>
>>>> I mean that why do you need explicit dependency tracking here when
>>>> dependencies on a PHY should happen automatically now. IOW, what is
>>>> special about this driver and dependency?
>>>
>>> Any update on this patch ? I think patch 2 can be merged, please
>>> let me know if this one can be dropped.
>>
>> Thanks for the feedback! You would say yes, you can merge patch 2,
>> except it probably does not even apply as it is written in a way that is
>> based on the changes in patch 1.
>>
>> I could rewrite patch 2 to not depend on patch 1 of course, but it
>> wouldn't make code simpler, perhaps more complex. And moreover the
>> hardware that I used to have access to has phy_count==1 so I could never
>> test the failing case, and sadly now I have no access to that hardware.
> 
> Hi Luca,
> 
> The fw_devlink code to create device links from consumers to "phys"
> suppliers is pretty well exercised. Most/all Android devices running
> 5.10+ kernels (including Pixel 6) use fw_devlink=on to be able to boot
> properly.
> 
> So I'd be pretty confident in deleting the device_link_add/del() code
> in drivers/pci/controller/dwc/pci-dra7xx.c. The device links should
> already be there before the probe is even called.
> 
> Also, if you want to check if the device links (even the 1 phy one you
> have) are being created, you can look at /sys/class/devlink to see the
> list of all device links that are currently present. You can delete
> the code and then use this to check too.

Thank you for your feedback. Unfortunately as I said I have no access to
the hardware, and won't have anymore. I don't think it is a good idea to
send a patch that I cannot test on real hardware, especially since it is
for a generic hardware that thus might affect others. But I would be
glad to review any such patch that might be sent, FWIW.

-- 
Luca
