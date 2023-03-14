Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FC46B985B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 15:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjCNOxu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 10:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjCNOxt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 10:53:49 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA11EF96;
        Tue, 14 Mar 2023 07:53:47 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id x19-20020a4a3953000000b00525191358b6so2344353oog.12;
        Tue, 14 Mar 2023 07:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678805626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4xB8YFLKwjGCy/SgLdu52hAdc8I/Bw00GcLZgZWTsU=;
        b=e3tkB3wmBpYkJNnmxSWP5pw47gHfyMTpSf/OGbrp4iaYBllcNr3vj+it6hnwaOZR+O
         nGR0NB+GH8IbCR5qUPsi2fU5ipan9a9OcZqskHwGE7ql37fFvP/LEtf/oR3PYDoSaX1Y
         4kS0xwC5FvLJSRmGQjqqB1PReF3l3c5JgGsR+KH9dC1rfUcg3pXn75ZBXKtUUzXT00fn
         FaAHo+WF5yDbhg/l6jyqdNmoTXsiQDcDK42P0POY9VH7jMYnG+BHDaUTzPwgSNxWtnYO
         X9lXswWNMW0V46q+OthKbbm7PjqQJ5ukntmyX2SmXoHEkE+xEC7glv3BfdhYgcQuh/vY
         lMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678805626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4xB8YFLKwjGCy/SgLdu52hAdc8I/Bw00GcLZgZWTsU=;
        b=QowuTqkDV8WKXWK+Y4Hg3ia8tc+ZGsVwqEssQELrDuoCAPtC7fawXixXSjk+C2Jcmo
         W0FQnCxUMXhMc11QjjWFsTB2hpnpIEhWixaA561lCGSiFHo5KljsOS/UFKqy42oBNbAF
         znl1ddTTiGX+V/TgbIIVFSECxVxxb9M6KbHmaFom1z9a7fTlC8FkfTdVCOBmXZ+8WsRf
         nyNnHThMcRvi/fJPgBIsVaBZaub4GgYVgGQ8/btkHFwr+oZt+PNuPCyYzE8v6DRymvM4
         c2FCJlaIEvIUPsTPVtl7tEXi++Zc6l5s20rWSbfpW9+yUOwIuLJoHLr4VULczQt1oZ/5
         jjmA==
X-Gm-Message-State: AO0yUKUn58lxIZBbt3IdZBmhHi7eoMEs1wqWHRSaqrhJ0aW0d7aBgGI8
        emcHZblc5J6a+xmXXNHTtORCEkUv/AxMJTkeuAQ=
X-Google-Smtp-Source: AK7set+Vbh8WigjwKyxtopSnp2Zi/JlEdRaNuOA7bBY6hnDUKltx7BMj0s8lTr2SsXRyzTQtBY9t4KEQVZs0Im/YJ8Q=
X-Received: by 2002:a4a:ca0c:0:b0:525:45d5:9de9 with SMTP id
 w12-20020a4aca0c000000b0052545d59de9mr14137931ooq.0.1678805626127; Tue, 14
 Mar 2023 07:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <ecd09f27-b799-4741-2c5a-a2de99776c51@opensource.wdc.com> <CAAEEuhrk4cSC312UiAL3UwoDZ=urrdDcBThcNHd1dqnAuJTzAw@mail.gmail.com>
 <3c4ed614-f088-928f-2807-deaa5e4b668a@opensource.wdc.com>
In-Reply-To: <3c4ed614-f088-928f-2807-deaa5e4b668a@opensource.wdc.com>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Tue, 14 Mar 2023 15:53:09 +0100
Message-ID: <CAAEEuhqk0scWd3wFbVb9fSgHxPBKotpEPNi+YPG4GD9vLO94mw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] PCI: rockchip: Fix RK3399 PCIe endpoint controller driver
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        rick.wertenbroek@heig-vd.ch, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 14, 2023 at 9:10=E2=80=AFAM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 3/14/23 16:57, Rick Wertenbroek wrote:
> > On Tue, Mar 14, 2023 at 1:02=E2=80=AFAM Damien Le Moal
> > <damien.lemoal@opensource.wdc.com> wrote:
> >>
> >> On 2/14/23 23:08, Rick Wertenbroek wrote:
> >>> This is a series of patches that fixes the PCIe endpoint controller d=
river
> >>> for the Rockchip RK3399 SoC. The driver was introduced in
> >>> cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe control=
ler")
> >>> The original driver had issues and would not allow for the RK3399 to
> >>> operate in PCIe endpoint mode correctly. This patch series fixes that=
 so
> >>> that the PCIe core controller of the RK3399 SoC can now act as a PCIe
> >>> endpoint. This is v2 of the patch series and addresses the concerns t=
hat
> >>> were raised during the review of the first version.
> >>
> >> Rick,
> >>
> >> Are you going to send a rebased V3 soon ? I have a couple of additiona=
l
> >> patches to add on top of your series...
> >>
> >
> > I'll try to send a V3 this week. The changes to V2 will be the issues
> > raised and discussed on the V2 here in the mailing list with the additi=
onal
> > code for removing the unsupported MSI-X capability list (was discussed
> > in the mailing list as well).
>
> Thanks.
>
> Additional patch needed to avoid problems with this controller is that
> we need to set ".align =3D 256" in the features. Otherwise, things do not
> work well. This is because the ATU drops the low 8-bits of the PCI
> addresses. It is a one liner patch, so feel free to add it to your series=
.
>
> I also noticed random issues wich seem to be due to link-up timing... We
> probably will need to implement a poll thread to detect and notify with
> the linkup callback when we actually have the link established with the
> host (see the dw-ep controller which does something similar).
>

Hello Damien,
I also noticed random issues I suspect to be related to link status or powe=
r
state, in my case it sometimes happens that the BARs (0-6) in the config
space get reset to 0. This is not due to the driver because the driver neve=
r
ever accesses these registers (@0xfd80'0010 to 0xfd80'0024 TRM
17.6.4.1.5-17.6.4.1.10).
I don't think the host rewrites them because lspci shows the BARs as
"[virtual]" which means they have been assigned by host but have 0
value in the endpoint device (when lspci rereads the PCI config header).
See https://github.com/pciutils/pciutils/blob/master/lspci.c#L422

So I suspect the controller detects something related to link status or
power state and internally (in hardware) resets those registers. It's not
the kernel code, it never accesses these regs. The problem occurs
very randomly, sometimes in a few seconds, sometimes I cannot see
it for a whole day.

Is this similar to what you are experiencing ?
Do you have any idea as to what could make these registers to be reset
(I could not find anything in the TRM, also nothing in the driver seems to
cause it).

>
> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Date: Thu, 9 Mar 2023 16:37:24 +0900
> Subject: [PATCH] PCI: rockchip: Set address alignment for endpoint mode
>
> The address translation unit of the rockchip EP controller does not use
> the lower 8 bits of a PCIe-space address to map local memory. Thus we
> must set the align feature field to 256 to let the user know about this
> constraint.
>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c
> b/drivers/pci/controller/pcie-rockchip-ep.c
> index 12db9a9d92af..c6a23db84967 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -471,6 +471,7 @@ static const struct pci_epc_features
> rockchip_pcie_epc_features =3D {
>         .linkup_notifier =3D false,
>         .msi_capable =3D true,
>         .msix_capable =3D false,
> +       .align =3D 256,
>  };
>
>  static const struct pci_epc_features*
> --
> 2.39.2
>
>
> --
> Damien Le Moal
> Western Digital Research
>

Do you want me to include this patch in the V3 series or will you
submit another patch series for the changes you applied on the RK3399 PCIe
endpoint controller ? I don't know if you prefer to build the V3
together or if you
prefer to submit another patch series on top of mine. Let me know.

Best regards.
Rick
