Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D645B5BBB
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 15:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiILN7O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Sep 2022 09:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiILN7M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Sep 2022 09:59:12 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C5A3136A;
        Mon, 12 Sep 2022 06:59:11 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D5B6061EA192E;
        Mon, 12 Sep 2022 15:59:09 +0200 (CEST)
Message-ID: <cd8d05ba-8bf4-486e-3e5d-9afb68698555@molgen.mpg.de>
Date:   Mon, 12 Sep 2022 15:59:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Dell XPS 13 9360/Dell DA300: USB Type-C: PCIe Bus Error:
 severity=Corrected, type=Data Link Layer, (Receiver ID)
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <ae28dabe-d339-b56d-4a8e-ce4291c9b836@molgen.mpg.de>
 <Yx858docsDh/ARiL@kuha.fi.intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <Yx858docsDh/ARiL@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear Heikki,


Am 12.09.22 um 15:53 schrieb Heikki Krogerus:

> On Mon, Sep 12, 2022 at 03:36:09PM +0200, Paul Menzel wrote:

>> On a Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022, connect a Dell DA300
>> to the only USB Type-C port on the left side (with a network cable connect),
>> Linux logs the warnings below:
> 
>> [   18.895120] ucsi_acpi USBC000:00: UCSI_GET_PDOS returned 0 bytes
> 
> This warning you already reported [1]. I will send a patch for this
> once I'm sure I understand what's going on. I'm fairly sure I now know
> what is causing that, but I will still run a few more tests to be
> absolutely sure.
> 
> The warning is in any case not critical.

The line slipped through. Sorry for the noise, and thank you for your 
reply. This thread was supposed to be for the PCIe bus errors.


Kind regards,

Paul


> [1] https://lore.kernel.org/linux-usb/726661bf-b95f-02fc-e7c5-c222820ee257@molgen.mpg.de/
