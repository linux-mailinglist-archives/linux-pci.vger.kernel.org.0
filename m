Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A982F742A4F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 18:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjF2QJ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 12:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjF2QJx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 12:09:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE651FD2;
        Thu, 29 Jun 2023 09:09:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD1B16156D;
        Thu, 29 Jun 2023 16:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6EDC433C0;
        Thu, 29 Jun 2023 16:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688054991;
        bh=vhzCcDGrCZn7v/AnfX+ZlH4QkMwDK30If/JXCB4OF1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VkVAWEkBpAUYJ1VHDghx8U2eug8D2go4ktax+QI74KbTtX9ZuyMle1c//inrZ5+W1
         z2uuCOeOy3afDTZqlHJK7kzn2XOobOrrNW+8kROq49Bb5XT8zYvhV55kkcE4QpWiGG
         5ORA/tY+0NmiYqL69wtae/pnhVu6YsmSK6UzOYKWVtOipscoWzhw7VIi66D8kwXfoR
         OXLBlndW03mlgWAalhulj/OnkwZgx78DQgD1/GWtZeIdTw4s5KaTj4rVoaVF1CwsRO
         X7ae9IR2Y5fvY4yqlqky7hTWfPjYTnW+gkw8dz4ggA39RsX7rk4vYaVWgYRmY4YCUg
         pwOsMozFGEBWg==
Date:   Thu, 29 Jun 2023 11:09:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [RFC PATCH 1/8] PCI: Add Intel Audio DSP devices to pci_ids.h
Message-ID: <20230629160949.GA399417@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230628205135.517241-2-amadeuszx.slawinski@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 28, 2023 at 10:51:28PM +0200, Amadeusz Sławiński wrote:
> Those IDs are mostly sprinkled between HDA, Skylake, SOF and avs drivers.
> Almost every use contains additional comments to identify to which
> platform those IDs refer to. Add those IDs to pci_ids.h header, so that
> there is one place which defines those names.
> 
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks for keeping these all sorted!  Feel free to merge this via the
ALSA tree or whereever the rest of the series goes.

> ---
>  include/linux/pci_ids.h | 44 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index a99b1fcfc617..de675c6cfb63 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2636,6 +2636,7 @@
>  
>  #define PCI_VENDOR_ID_INTEL		0x8086
>  #define PCI_DEVICE_ID_INTEL_EESSC	0x0008
> +#define PCI_DEVICE_ID_INTEL_HDA_CML_LP	0x02c8
>  #define PCI_DEVICE_ID_INTEL_PXHD_0	0x0320
>  #define PCI_DEVICE_ID_INTEL_PXHD_1	0x0321
>  #define PCI_DEVICE_ID_INTEL_PXH_0	0x0329
> @@ -2651,6 +2652,7 @@
>  #define PCI_DEVICE_ID_INTEL_82424	0x0483
>  #define PCI_DEVICE_ID_INTEL_82378	0x0484
>  #define PCI_DEVICE_ID_INTEL_82425	0x0486
> +#define PCI_DEVICE_ID_INTEL_HDA_CML_H	0x06c8
>  #define PCI_DEVICE_ID_INTEL_MRST_SD0	0x0807
>  #define PCI_DEVICE_ID_INTEL_MRST_SD1	0x0808
>  #define PCI_DEVICE_ID_INTEL_MFD_SD	0x0820
> @@ -2662,12 +2664,19 @@
>  #define PCI_DEVICE_ID_INTEL_QUARK_X1000_ILB	0x095e
>  #define PCI_DEVICE_ID_INTEL_I960	0x0960
>  #define PCI_DEVICE_ID_INTEL_I960RM	0x0962
> +#define PCI_DEVICE_ID_INTEL_HDA_HSW_0	0x0a0c
> +#define PCI_DEVICE_ID_INTEL_HDA_HSW_2	0x0c0c
>  #define PCI_DEVICE_ID_INTEL_CENTERTON_ILB	0x0c60
> +#define PCI_DEVICE_ID_INTEL_HDA_HSW_3	0x0d0c
> +#define PCI_DEVICE_ID_INTEL_HDA_BYT	0x0f04
>  #define PCI_DEVICE_ID_INTEL_8257X_SOL	0x1062
>  #define PCI_DEVICE_ID_INTEL_82573E_SOL	0x1085
>  #define PCI_DEVICE_ID_INTEL_82573L_SOL	0x108f
>  #define PCI_DEVICE_ID_INTEL_82815_MC	0x1130
>  #define PCI_DEVICE_ID_INTEL_82815_CGC	0x1132
> +#define PCI_DEVICE_ID_INTEL_HDA_MRFLD	0x119a
> +#define PCI_DEVICE_ID_INTEL_HDA_BDW	0x160c
> +#define PCI_DEVICE_ID_INTEL_HDA_APL_T	0x1a98
>  #define PCI_DEVICE_ID_INTEL_82092AA_0	0x1221
>  #define PCI_DEVICE_ID_INTEL_7505_0	0x2550
>  #define PCI_DEVICE_ID_INTEL_7205_0	0x255d
> @@ -2710,6 +2719,7 @@
>  #define PCI_DEVICE_ID_INTEL_PANTHERPOINT_LPC_MIN	0x1e40
>  #define PCI_DEVICE_ID_INTEL_PANTHERPOINT_LPC_MAX	0x1e5f
>  #define PCI_DEVICE_ID_INTEL_VMD_201D	0x201d
> +#define PCI_DEVICE_ID_INTEL_HDA_BSW	0x2284
>  #define PCI_DEVICE_ID_INTEL_DH89XXCC_LPC_MIN	0x2310
>  #define PCI_DEVICE_ID_INTEL_DH89XXCC_LPC_MAX	0x231f
>  #define PCI_DEVICE_ID_INTEL_82801AA_0	0x2410
> @@ -2875,6 +2885,7 @@
>  #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_ADDR_REV2  0x2db1
>  #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_RANK_REV2  0x2db2
>  #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_TC_REV2    0x2db3
> +#define PCI_DEVICE_ID_INTEL_HDA_GML	0x3198
>  #define PCI_DEVICE_ID_INTEL_82855PM_HB	0x3340
>  #define PCI_DEVICE_ID_INTEL_IOAT_TBG4	0x3429
>  #define PCI_DEVICE_ID_INTEL_IOAT_TBG5	0x342a
> @@ -2885,6 +2896,7 @@
>  #define PCI_DEVICE_ID_INTEL_IOAT_TBG1	0x3431
>  #define PCI_DEVICE_ID_INTEL_IOAT_TBG2	0x3432
>  #define PCI_DEVICE_ID_INTEL_IOAT_TBG3	0x3433
> +#define PCI_DEVICE_ID_INTEL_HDA_ICL_LP	0x34c8
>  #define PCI_DEVICE_ID_INTEL_82830_HB	0x3575
>  #define PCI_DEVICE_ID_INTEL_82830_CGC	0x3577
>  #define PCI_DEVICE_ID_INTEL_82854_HB	0x358c
> @@ -2917,6 +2929,7 @@
>  #define PCI_DEVICE_ID_INTEL_IOAT_JSF9	0x3719
>  #define PCI_DEVICE_ID_INTEL_QAT_C62X	0x37c8
>  #define PCI_DEVICE_ID_INTEL_QAT_C62X_VF	0x37c9
> +#define PCI_DEVICE_ID_INTEL_HDA_ICL_N	0x38c8
>  #define PCI_DEVICE_ID_INTEL_ICH10_0	0x3a14
>  #define PCI_DEVICE_ID_INTEL_ICH10_1	0x3a16
>  #define PCI_DEVICE_ID_INTEL_ICH10_2	0x3a18
> @@ -2961,12 +2974,27 @@
>  #define PCI_DEVICE_ID_INTEL_SBRIDGE_SAD0	0x3cf4	/* 12.6 */
>  #define PCI_DEVICE_ID_INTEL_SBRIDGE_BR		0x3cf5	/* 13.6 */
>  #define PCI_DEVICE_ID_INTEL_SBRIDGE_SAD1	0x3cf6	/* 12.7 */
> +#define PCI_DEVICE_ID_INTEL_HDA_ICL_H	0x3dc8
>  #define PCI_DEVICE_ID_INTEL_IOAT_SNB	0x402f
>  #define PCI_DEVICE_ID_INTEL_5400_ERR	0x4030
>  #define PCI_DEVICE_ID_INTEL_5400_FBD0	0x4035
>  #define PCI_DEVICE_ID_INTEL_5400_FBD1	0x4036
> +#define PCI_DEVICE_ID_INTEL_HDA_JSL_N	0x4dc8
> +#define PCI_DEVICE_ID_INTEL_HDA_TGL_H	0x43c8
> +#define PCI_DEVICE_ID_INTEL_HDA_EHL_0	0x4b55
> +#define PCI_DEVICE_ID_INTEL_HDA_EHL_3	0x4b58
>  #define PCI_DEVICE_ID_INTEL_EP80579_0	0x5031
>  #define PCI_DEVICE_ID_INTEL_EP80579_1	0x5032
> +#define PCI_DEVICE_ID_INTEL_HDA_ADL_P	0x51c8
> +#define PCI_DEVICE_ID_INTEL_HDA_ADL_PS	0x51c9
> +#define PCI_DEVICE_ID_INTEL_HDA_RPL_P_0	0x51ca
> +#define PCI_DEVICE_ID_INTEL_HDA_RPL_P_1	0x51cb
> +#define PCI_DEVICE_ID_INTEL_HDA_ADL_M	0x51cc
> +#define PCI_DEVICE_ID_INTEL_HDA_ADL_PX	0x51cd
> +#define PCI_DEVICE_ID_INTEL_HDA_RPL_M	0x51ce
> +#define PCI_DEVICE_ID_INTEL_HDA_RPL_PX	0x51cf
> +#define PCI_DEVICE_ID_INTEL_HDA_ADL_N	0x54c8
> +#define PCI_DEVICE_ID_INTEL_HDA_APL	0x5a98
>  #define PCI_DEVICE_ID_INTEL_5100_16	0x65f0
>  #define PCI_DEVICE_ID_INTEL_5100_19	0x65f3
>  #define PCI_DEVICE_ID_INTEL_5100_21	0x65f5
> @@ -3000,6 +3028,9 @@
>  #define PCI_DEVICE_ID_INTEL_82443GX_0	0x71a0
>  #define PCI_DEVICE_ID_INTEL_82443GX_2	0x71a2
>  #define PCI_DEVICE_ID_INTEL_82372FB_1	0x7601
> +#define PCI_DEVICE_ID_INTEL_HDA_RPL_S	0x7a50
> +#define PCI_DEVICE_ID_INTEL_HDA_ADL_S	0x7ad0
> +#define PCI_DEVICE_ID_INTEL_HDA_MTL	0x7e28
>  #define PCI_DEVICE_ID_INTEL_SCH_LPC	0x8119
>  #define PCI_DEVICE_ID_INTEL_SCH_IDE	0x811a
>  #define PCI_DEVICE_ID_INTEL_E6XX_CU	0x8183
> @@ -3011,8 +3042,21 @@
>  #define PCI_DEVICE_ID_INTEL_84460GX	0x84ea
>  #define PCI_DEVICE_ID_INTEL_IXP4XX	0x8500
>  #define PCI_DEVICE_ID_INTEL_IXP2800	0x9004
> +#define PCI_DEVICE_ID_INTEL_HDA_LKF	0x98c8
>  #define PCI_DEVICE_ID_INTEL_VMD_9A0B	0x9a0b
> +#define PCI_DEVICE_ID_INTEL_HDA_SKL_LP	0x9d70
> +#define PCI_DEVICE_ID_INTEL_HDA_KBL_LP	0x9d71
> +#define PCI_DEVICE_ID_INTEL_HDA_CNL_LP	0x9dc8
> +#define PCI_DEVICE_ID_INTEL_HDA_TGL_LP	0xa0c8
> +#define PCI_DEVICE_ID_INTEL_HDA_SKL	0xa170
> +#define PCI_DEVICE_ID_INTEL_HDA_KBL	0xa171
> +#define PCI_DEVICE_ID_INTEL_HDA_KBL_H	0xa2f0
> +#define PCI_DEVICE_ID_INTEL_HDA_CNL_H	0xa348
> +#define PCI_DEVICE_ID_INTEL_HDA_CML_S	0xa3f0
> +#define PCI_DEVICE_ID_INTEL_HDA_LNL_P	0xa828
>  #define PCI_DEVICE_ID_INTEL_S21152BB	0xb152
> +#define PCI_DEVICE_ID_INTEL_HDA_CML_R	0xf0c8
> +#define PCI_DEVICE_ID_INTEL_HDA_RKL_S	0xf1c8
>  
>  #define PCI_VENDOR_ID_WANGXUN		0x8088
>  
> -- 
> 2.34.1
> 
