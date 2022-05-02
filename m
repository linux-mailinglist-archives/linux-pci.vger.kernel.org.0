Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB2F516F69
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 14:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384991AbiEBMTn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 08:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384965AbiEBMTm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 08:19:42 -0400
X-Greylist: delayed 9429 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 May 2022 05:16:04 PDT
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8539915A1A;
        Mon,  2 May 2022 05:16:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 609183FA5E;
        Mon,  2 May 2022 12:16:00 +0000 (UTC)
Message-ID: <f241698b-96ad-6268-217d-da64d8d7cb22@marcan.st>
Date:   Mon, 2 May 2022 21:15:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/3] PCI: apple: Add support for optional PWREN GPIO
Content-Language: es-ES
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220502093832.32778-1-marcan@marcan.st>
 <20220502093832.32778-4-marcan@marcan.st> <87ee1ci5u8.wl-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <87ee1ci5u8.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 02/05/2022 19.31, Marc Zyngier wrote:
> On Mon, 02 May 2022 10:38:32 +0100,
> Hector Martin <marcan@marcan.st> wrote:
>>
>> WiFi and SD card devices on M1 Macs have a separate power enable GPIO.
>> Add support for this to the PCIe controller. This is modeled after how
>> pcie-fu740 does it.
> 
> Please update the DT binding to reflect this as an optional property.

That's a bit more involved than you might think, considering we aren't
checking *any* properties in the root port child nodes right now :-)

How's this?

patternProperties:
  "^pci@":
    $ref: /schemas/pci/pci-bus.yaml#
    type: object
    description: A single PCI root port

    properties:
      reg:
        maxItems: 1

      pwren-gpios:
        description: Optional GPIO to power on the device
        maxItems: 1

    required:
      - reset-gpios
      - interrupt-controller
      - "#interrupt-cells"
      - interrupt-map-mask
      - interrupt-map

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
