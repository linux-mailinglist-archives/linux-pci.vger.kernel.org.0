Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278E36BA2BD
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 23:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjCNWyZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 18:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCNWyY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 18:54:24 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AE538EA2
        for <linux-pci@vger.kernel.org>; Tue, 14 Mar 2023 15:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678834462; x=1710370462;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4mWBwFLpOe+3Lg11FkokGIfBuGEGGfu3AKmmd26Q/z8=;
  b=nID0T+oTUUFzJDkgi/76HGS2tUEI3jFVvJ2JFCFaeM3SFkkI7UpXf46/
   P4TO4E7rkZ9Cet9WWWHU0QEBcwBG7Xw3ub1Td3lgbJ55SbLpMrhJa3rZk
   wxGAgnt4eCEox+clyicB4mVUly1kXmcMHEZBIMafw3TlREPyVR7URMqGt
   xjEO0HbU2douG2Eadz35GmF4vAOAT5sOeq1KMyzHpxPC9vsGSOchXTtdp
   XbT/9qIbHJYz1KbCYGQ7SL+cruPSXFCzykHT4PXAJymx5L9R090seIiAo
   xsIA41yq7gcP4ypPtCvkKmIkWpBL8oQqfEFL2vhPxyQ70R3JuH8KXiOdL
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,261,1673884800"; 
   d="scan'208";a="230589588"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 06:54:21 +0800
IronPort-SDR: 8oj1/ZGwbpb6DZqVZEXHcjTrk0RvUotkf0TKhfLRSMneiC0HbRSWCtzHODxSmEkRbkBkryWvZf
 UF6I+WKFVbDzmUgMhZtIahM1GFwe4OwY7iBMktP7QtXd4+J3Vgx3QUo5pTMAu7cahK4bjUOstr
 6C2goxNIgI+P7jY3q6WEFOPlI9WPaTOWhMBId7HMIdSBrJynZPint1nfsD3oWKJcZMX/k7OGJy
 y+MWxCvXpMr9fa8s497GhEdDtfxSgDHQ0KyHFcFGrNfm6i3VE61I6Xqzgzzq9IJGAnJHJJA49l
 aw8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 15:05:07 -0700
IronPort-SDR: aRS6H+B163A1HKS7dbncw/HO7zWflqaCzTfxe2ajzv+bZShMYbr3VCbCrEvJ0xXyQSuoSjUt+j
 BpZh/8MZFz5v1m5Bfz+xR5R6eOFVY4OerlvhjA0iFMcvDY5O/oMBYJDZGkMZ4VyYqCrqhb6nj5
 L249JijQ6rzGWu6fPLWmUs32mFtZiRQ0HeKKKstjs+76HAlGbNNuSZB/Xu4dFAh3LLch2quLhh
 OnhyYQv2B4vyio+GmPLHPyU7+5Uo+995ctCczLLmh/7mcwwD65Eoj5Mj4ubi2XI2C0Eafq1Ave
 tn8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 15:54:21 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pbpk41n1Lz1RtW1
        for <linux-pci@vger.kernel.org>; Tue, 14 Mar 2023 15:54:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678834458; x=1681426459; bh=4mWBwFLpOe+3Lg11FkokGIfBuGEGGfu3AKm
        md26Q/z8=; b=L3dZG1sWWAikqJiWmwg5q3YwNB+cbQ4rqZ2QbvfzfRdZou7SOQr
        78lip1o4qHhDVm7kyyner0SSRoqWjsYLH9H8cgGIn5HxkY0fNeF5q6bUFTSAgg/e
        DPZL2Djv2bF9/ce4aFgHx8SmSBe0TKRUZB9OxwqgoCRBoPbxSSgMRDeY4pn1ERzd
        sXGtkzEQQXn6SWVRFRVXszUI6m9kkE8LHyn5nsakjNJrSdp30gZhwOW3BXQSiCEP
        kMmCQKFtfhvxidNbdVQdBS2wsBmdRiFhAvJWeU0f411vGq+h9zZb8TA/XTSEHcKL
        7d3P0WxkB0lWqwQGWF9bdKC0o288HlyG3xw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8yJ085IZeNuS for <linux-pci@vger.kernel.org>;
        Tue, 14 Mar 2023 15:54:18 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pbpjz2ZH9z1RtVm;
        Tue, 14 Mar 2023 15:54:15 -0700 (PDT)
Message-ID: <8392a7de-666a-bce6-dc9f-b60d6dd93013@opensource.wdc.com>
Date:   Wed, 15 Mar 2023 07:54:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/9] PCI: rockchip: Fix RK3399 PCIe endpoint controller
 driver
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        rick.wertenbroek@heig-vd.ch, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <ecd09f27-b799-4741-2c5a-a2de99776c51@opensource.wdc.com>
 <CAAEEuhrk4cSC312UiAL3UwoDZ=urrdDcBThcNHd1dqnAuJTzAw@mail.gmail.com>
 <3c4ed614-f088-928f-2807-deaa5e4b668a@opensource.wdc.com>
 <CAAEEuhqk0scWd3wFbVb9fSgHxPBKotpEPNi+YPG4GD9vLO94mw@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAAEEuhqk0scWd3wFbVb9fSgHxPBKotpEPNi+YPG4GD9vLO94mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/14/23 23:53, Rick Wertenbroek wrote:
> Hello Damien,
> I also noticed random issues I suspect to be related to link status or power
> state, in my case it sometimes happens that the BARs (0-6) in the config
> space get reset to 0. This is not due to the driver because the driver never
> ever accesses these registers (@0xfd80'0010 to 0xfd80'0024 TRM
> 17.6.4.1.5-17.6.4.1.10).
> I don't think the host rewrites them because lspci shows the BARs as
> "[virtual]" which means they have been assigned by host but have 0
> value in the endpoint device (when lspci rereads the PCI config header).
> See https://github.com/pciutils/pciutils/blob/master/lspci.c#L422
> 
> So I suspect the controller detects something related to link status or
> power state and internally (in hardware) resets those registers. It's not
> the kernel code, it never accesses these regs. The problem occurs
> very randomly, sometimes in a few seconds, sometimes I cannot see
> it for a whole day.
> 
> Is this similar to what you are experiencing ?

Yes. I sometimes get NMIs after starting the function driver, when my function
driver starts probing the bar registers after seeing the host changing one
register. And the link also comes up with 4 lanes or 2 lanes, random.

> Do you have any idea as to what could make these registers to be reset
> (I could not find anything in the TRM, also nothing in the driver seems to
> cause it).

My thinking is that since we do not have a linkup notifier, the function driver
starts setting things up without the link established (e.g. when the host is
still powered down). Once the host start booting and pic link is established,
things may be reset in the hardware... That is the only thing I can think of.

And yes, there are definitely something going on with the power states too I
think: if I let things idle for a few minutes, everything stops working: no
activity seen on the endpoint over the BARs. I tried enabling the sys and client
interrupts to see if I can see power state changes, or if clearing the
interrupts helps (they are masked by default), but no change. And booting the
host with pci_aspm=off does not help either. Also tried to change all the
capabilities related to link & power states to "off" (not supported), and no
change either. So currently, I am out of ideas regarding that one.

I am trying to make progress on my endpoint driver (nvme function) to be sure it
is not a bug there that breaks things. I may still have something bad because
when I enable the BIOS native NVMe driver on the host, either the host does not
boot, or grub crashes with memory corruptions. Overall, not yet very stable and
still trying to sort out the root cause of that.


> Do you want me to include this patch in the V3 series or will you
> submit another patch series for the changes you applied on the RK3399 PCIe
> endpoint controller ? I don't know if you prefer to build the V3
> together or if you
> prefer to submit another patch series on top of mine. Let me know.

If it is no trouble, please include it with your series. Will be easier to
retest everything together :)

-- 
Damien Le Moal
Western Digital Research

