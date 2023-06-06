Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E6D7243B6
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 15:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbjFFNHz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 09:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbjFFNHy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 09:07:54 -0400
X-Greylist: delayed 2731 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Jun 2023 06:07:23 PDT
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C8B199A;
        Tue,  6 Jun 2023 06:07:23 -0700 (PDT)
Received: from [90.160.41.100] (helo=[10.105.1.14])
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1q6Vh5-00AOz5-Fy; Tue, 06 Jun 2023 13:21:47 +0100
Message-ID: <d5140a48-7841-af9d-7560-acd677caec88@codethink.co.uk>
Date:   Tue, 6 Jun 2023 13:21:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] dt-bindings: updated max-link-speed for newer
 generations
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Jude Onyenegecha <jude.onyenegecha@codethink.co.uk>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jeegar Lakhani <jeegar.lakhani@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <ZHeZxPRGw+X83V1k@bhelgaas>
Content-Language: en-GB
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <ZHeZxPRGw+X83V1k@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 31/05/2023 20:02, Bjorn Helgaas wrote:
> Possible subject:
> 
>    dt-bindings: Add gen5, gen6 max-link-speed values
> 
> On Wed, May 31, 2023 at 10:21:21AM +0100, Ben Dooks wrote:
>> Add updated max-link-speed values for newer generation PCIe link
>> speeds.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>> Cc: devicetree@vger.kernel.org
>> ---
>>   Documentation/devicetree/bindings/pci/pci.txt | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
>> index 6a8f2874a24d..56391e193fc4 100644
>> --- a/Documentation/devicetree/bindings/pci/pci.txt
>> +++ b/Documentation/devicetree/bindings/pci/pci.txt
>> @@ -22,8 +22,9 @@ driver implementation may support the following properties:
>>      If present this property specifies PCI gen for link capability.  Host
>>      drivers could add this as a strategy to avoid unnecessary operation for
>>      unsupported link speed, for instance, trying to do training for
>> -   unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
>> -   for gen2, and '1' for gen1. Any other values are invalid.
>> +   unsupported link speed, etc.  Must be '6' for gen6,  '5' for gen5,
>> +   '4' for gen4, '3' for gen3, '2' for gen2, and '1' for gen1.
>> +   Any other values are invalid.
> 
> I really wish we'd used values with some connection to the actual
> speed, e.g., "16" for 16 GT/s.  These "gen X" values are a real hassle
> to convert back to the speed.  But I guess that's water under the
> bridge.
> 
> Maybe we should annotate the documentation here, though, e.g.,
> 
>    '6' for gen6 (64.0 GT/s), '5' for gen5 (32.0 GT/s), ...
> 
> Do I have that right?  I don't see "gen5" etc in the specs themselves,
> so this is just based on Google.
> 
> Bjorn 

I checked the wikipedia, I've been working on a yet-to-be-released
device that uses a gen5 phy so updating this would be useful.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

