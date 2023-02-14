Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D945697249
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 00:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjBNX7E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 18:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjBNX6x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 18:58:53 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CA2305FD
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 15:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676419119; x=1707955119;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0wzbE5dbKeg6zwPSACvcz44HHBT+V6cdN+UmWihI6ko=;
  b=cp8vlLg+QSNDl0ner2939ThO91W4kik3F6DbJOF+vKgPcWoN7+DlKSKF
   DTBtoY3qr5Ry5FbxjCqxGzuNpigkcxjDXV/3H8D1cr41S6kLnoFFNGL8A
   UJSJySfCnBi2+fFihrQGQQXxnYiH2s8ZoLTvlQRLGKwHKUJTkNK1GSjm+
   PPUviWxyfq4ivLynw11QLAtYiH90TdlBKG8sYLNqobq8HK4LTdblvCLPT
   64YWYB0PDe5jHHrWPvBevYXpIi4GI026SiHdaVl6Qc0FFk4uUBQwOSLoy
   uMhRbhkYySMnzw+1vqlKEE1bD1IFnQSenaKZYOww6Tt5tcd8pcfW0kv5L
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="223337717"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 07:58:21 +0800
IronPort-SDR: u1BhP4BYbGo53ptnkMhTLyNh9cxwrJUgDtfB2MojiORNzzk9ncI4H9rABQ/qByHG9CsJfhHEB/
 d34Gtfqoow+6Lg6qlU7Sswr7rnpRMbNetKx88Vqgt/W3hdkPYzAbU0IauezBzsDVPJdqQcZ39U
 pndBYCam+wJP0pe28hiCIIR3WF+W/iNyX7O/Z6U0ujt7Cb4e65xKIJa6Cj4CYj7aY4PWVwl4/M
 BSyTW8Y/8gtFOketbutsmjLrBHq/Puou3AiIBohLhQJGuKGqA+OXGMkR+bGNnzYHzyiXofGLmh
 mL4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 15:09:44 -0800
IronPort-SDR: Xrvm0Wrz6ffsmdbrIjKUZNCF4PaC8PJpmVg2SfejzAJceEDGPKDv/6gBHQRv1jjNr1WLESP49q
 JrRUpVyWsDMDm+G6IakjTDGaDV05NCcnwprEsTvpjfFwrgTeKZ73tBqRa2Qn1/4ObD1MHGfTDE
 nFV6Zmi5aisB67S4GcaoL7htdo1+x73e2Wr706PkC2YxpoC3ryKQXlVUUr7hj8H+DktN+X+7qo
 ytEPt4SEKNJymFz1om2FGggQz0rmM4Yp6H3DwYnXRIWgd1gGHN2BAMb1b5os5fLR5ZrQoP8/x+
 dKU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 15:58:22 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGdSs1RMwz1RWxq
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 15:58:21 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676419100; x=1679011101; bh=0wzbE5dbKeg6zwPSACvcz44HHBT+V6cdN+U
        mWihI6ko=; b=nhXWsH1w2yUI7rcUShKvBVvquthT7csOKjfHohg73oprsbOPmZJ
        Trnzjb3ZgU+4gk8qjDRxw2Tv+ixOPtvRt8n7rLaJzbqMg/3thVaZ7sZBr18jZUA/
        z0bg3UCtvtxN0rm793uev6UJIGaHtwItlwcdvZM0vEr9zq58xCQ4raacivhrKfUN
        HGA1RE6kMSO631u9NgPoqWoqxW17YH3kPmumVgmdLn0SAPWnqCb2QBrIREBy6oBJ
        836YHVC4u7NF6G4re+p0Twqs9a1IsJVL53mo8JU++ISQiEPHdMDhmby5ryWH4vS2
        qY0DzbxL0XEGslkDq817CK8CfgyFUqrMfdg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1VCzfx18VDU2 for <linux-pci@vger.kernel.org>;
        Tue, 14 Feb 2023 15:58:20 -0800 (PST)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGdSn36S3z1RvLy;
        Tue, 14 Feb 2023 15:58:17 -0800 (PST)
Message-ID: <f8db1d50-5771-44e0-cb39-64425966f35f@opensource.wdc.com>
Date:   Wed, 15 Feb 2023 08:58:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/9] PCI: rockchip: Assert PCI Configuration Enable bit
 after probe
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <20230214140858.1133292-4-rick.wertenbroek@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230214140858.1133292-4-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/14/23 23:08, Rick Wertenbroek wrote:
> Assert PCI Configuration Enable bit after probe. When this bit is left to
> 0 in the endpoint mode, the RK3399 PCIe endpoint core will generate
> configuration request retry status (CRS) messages back to the root complex.
> Assert this bit after probe to allow the RK3399 PCIe endpoint core to reply
> to configuration requests from the root complex.
> This is documented in section 17.5.8.1.2 of the RK3399 TRM.
> 
> Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

