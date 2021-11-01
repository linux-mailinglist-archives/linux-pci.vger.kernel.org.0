Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EC6441DBA
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 17:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhKAQL1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 12:11:27 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54844 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhKAQL0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Nov 2021 12:11:26 -0400
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CB7A5929;
        Mon,  1 Nov 2021 17:08:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1635782931;
        bh=5X8h6B4J9nKftqUEua3y1P4PidUCDKB6s0zCtGEOFm8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PO3PxmDCy3EX0aOBBJf9O6VVVzCAWVsonfrOPgMDYqwghLVYLKQHJTH1NtgRVbKjo
         qU154sRuD8mTEoe7hbtcTk7sgXo5Ioatz0ykqeqb91qxzsWmGLq+Y2QS23UD350Zy8
         zEwlz70Idk1EWWH5OA1s0pHMpKhnOv7uoUF/byXY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e4acfe90021e45658e82ed042746707ace208a93.1635337518.git.geert+renesas@glider.be>
References: <e4acfe90021e45658e82ed042746707ace208a93.1635337518.git.geert+renesas@glider.be>
Subject: Re: [PATCH] dt-bindings: pci: rcar-pci-ep: Document r8a7795
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date:   Mon, 01 Nov 2021 16:08:49 +0000
Message-ID: <163578292915.275423.4456090259715745689@Monstersaurus>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Geert,

Quoting Geert Uytterhoeven (2021-10-27 13:26:36)
> From: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
>=20
> Document the support for R-Car PCIe EP on R8A7795 SoC device.
>=20
> Signed-off-by: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

This one reduces some noise too ;-) Thanks.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml b/Doc=
umentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> index 295840cf612f9377..32a3b7665ff5473c 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> @@ -19,6 +19,7 @@ properties:
>            - renesas,r8a774b1-pcie-ep     # RZ/G2N
>            - renesas,r8a774c0-pcie-ep     # RZ/G2E
>            - renesas,r8a774e1-pcie-ep     # RZ/G2H
> +          - renesas,r8a7795-pcie-ep      # R-Car H3
>        - const: renesas,rcar-gen3-pcie-ep # R-Car Gen3 and RZ/G2
> =20
>    reg:
> --=20
> 2.25.1
>
