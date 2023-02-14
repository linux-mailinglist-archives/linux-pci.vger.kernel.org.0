Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AB1697234
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 00:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjBNX52 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 18:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjBNX5W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 18:57:22 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84137193E8
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 15:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676419041; x=1707955041;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kzhGYJXOf306NmlEn5opNfn1hoJ34kE37xo2DHXERFc=;
  b=KKS+BvwYq3LE4jrF1l6x3SFOcrF1ldJvBGmd/VfTILRYvIhlcNfIfaL1
   jFDvnbvDcqAgTSLq3H+mJTyosa6Jgr8tHv9CkGH8lI26rOoMLJyu/+YqN
   b0xyUvxR//30RSivQy4s0pW0bGF5HQFXk9Ai86H23xt42iU0XDXrz4XHc
   0N+kRTqmbCclw50naiAbegOze60VtnmL3A+2lWzDOZ8LXARj4vgcnAzZ2
   SG2bKsgqbnZ/V0FfVPcIFqobouopAkXPrUH63NQa/Ao7TLGSriI2Yu38H
   NgvCqDcyMdv+Y8Z1kmkdydtWAqSQCPANEoD+/RbZuyscu4F1CnOEZbBmj
   A==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="223111127"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 07:57:21 +0800
IronPort-SDR: +bwZaValNY5h9wXVpWFnmc1EGyiOGdg/qUCZ3x4D9DMI3pnXJ3t3qTfo++dv+9JDAO0oE6Ivj6
 eGG5QoK3fICP6ngm7Gl5OSkqM3VYyOyTli2rg7XC+OCqKuZI5zD61+sLs/HO1t9WPUihmlzzHA
 X10WeEkXcfcV/hXhsQkhZmlgw7tQLiKYGmJDqO4/xEb2SKOZzaxedXtToPVd+gnLZUWNjzgAnx
 L8Bs12m7hSbUkcP5SXgqlLAvXis8SCbOcE0WJllklRWjqUhyEOw+Jnp5kSz7evllaijM7s5QyP
 2/Y=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 15:08:44 -0800
IronPort-SDR: /bqGXZgpb2+lay9KGjnUgTbynWrlu32jV/da8xETZdGpNdKi+j4kg08EFNUyIaGheLtElYfwgv
 QLibz1Fo7g5m5te6YLFtRcs592Z5X23l5UeRdM7ln6zAWYdhzkI88VXTcBCI4K7sGdWFQYE6g3
 JmyTnTD/8h3h9uA+Sj7wyS6s5ckS01pshOJ+jlVB01glpGOZbq1F0gU2ks5uWgDIhbzotL8bg3
 MexW86KAmOzmKgPOLnHbLhIpFwsuRcx1WcUbtiQcU4orJ3uEuOQgNsYCX2L/eow1/wLOyc+kBV
 3YE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 15:57:21 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGdRh6Wf3z1RwqL
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 15:57:20 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676419040; x=1679011041; bh=kzhGYJXOf306NmlEn5opNfn1hoJ34kE37xo
        2DHXERFc=; b=qtkNz2Wpym57AeM1b+K40tUtO/VGjSmC/pa1V1esQDXbhLvdyNK
        KCxWZ30JUzdT2KyvLu/W4vsdZdU8LQZqmUsA+OsmmypSyNYILWQ+qHV5aRo3I8hk
        nsevRGb0wKA29ZVCKMO9SdPSd7yX77sEqAdQTQJTP5Y6etLUINbTCfzXs74T+5he
        nDk70r765uIM5/Wtorgc8G7qMvfSQVI1QfYPkAd6prG3s7FC6XnHLHP8nsEGHEDa
        8p344hbSMQfLiezuVqdxOquyLD21qHSGp35EJj34jZsB7HBozt47ZybM1X9n7NHt
        F9QRJy9witvlnydLDUtHB1YEzkGAnnYc1Og==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NaTC0Kh2Hplt for <linux-pci@vger.kernel.org>;
        Tue, 14 Feb 2023 15:57:20 -0800 (PST)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGdRd292Tz1RvLy;
        Tue, 14 Feb 2023 15:57:17 -0800 (PST)
Message-ID: <b6a27883-5d79-1125-70a7-ba987b397bcc@opensource.wdc.com>
Date:   Wed, 15 Feb 2023 08:57:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/9] PCI: rockchip: Write PCI Device ID to correct
 register
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, rick.wertenbroek@heig-vd.ch,
        stable@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <20230214140858.1133292-3-rick.wertenbroek@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230214140858.1133292-3-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/14/23 23:08, Rick Wertenbroek wrote:
> Write PCI Device ID (DID) to the correct register. The Device ID was not
> updated through the correct register. Device ID was written to a read-only
> register and therefore did not work. The Device ID is now set through the
> correct register. This is documented in the RK3399 TRM section 17.6.6.1.1
> 
> Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

