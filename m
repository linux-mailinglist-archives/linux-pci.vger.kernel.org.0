Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8837C89B8F
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 12:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfHLKeP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 06:34:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43792 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbfHLKeO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2019 06:34:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so29523315wru.10;
        Mon, 12 Aug 2019 03:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dtSTTUUBqdhvdDXLf5hsOIn63I5eQ1MYrFt/Dlyzq7c=;
        b=lVImMMz2WSbCGkQ78isy9YytFeejo4tBiKbmYGYa1Dg+7NeKJUQkvI0v9RlzObW26N
         TeHQC+sTskIWViBkdRT/sBofC2pkPxiZvV+rxeFihw4Xt/WhkfvG2Einp+iWgNMmEpW8
         uqSe5NEJtQ1V8yf8jdPVgJRKzfv/jU9xO8l7Ris74Vittim5wCd3qL+c1jhg4W72x/LA
         h8tv7VjCHZsZl5h95SVVBtdZ4Ibats461YNXWenyj8Oo3dXPrGCNdFIbupUwIR80HuCo
         BOcxBVUPso/dmiYuJKzklwN72bHGrIwo4l+R2mEnDjAVSQqCdHNqfamL8WIsXkfCcs4X
         2gFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dtSTTUUBqdhvdDXLf5hsOIn63I5eQ1MYrFt/Dlyzq7c=;
        b=uZmYS+3blvNXAZVXfLMgac1EvnIBdMSYodZY7uRQLeRwDk9Eh4G0FFtz/jZ3rlTrNx
         rTDMs6ZomNHeigx+UTs2+rLF0v7ky+iVimrNjc7ZfeXqUFCht1NwhJ8xkiVfV52Xb8wi
         it8ZTQTXgOjy4K/MbXWza1G0ZOw9PPuf8c2EUHe+7c8wHJWj5VwCCqph+q6cCbYkkz/k
         FjWBXjAAKywbbl7hTHK9wENXyTM8ed3yfP7cJBOXq6LSF2I4VL2itXfLL/rmD8YMwq1X
         A/Fxff3d58j3yUYlsjEt1JLbCVSrQ371K0rOGDJ0v0K/EHy8RXK1LSMcTlbRMGh+nVHL
         +Zkw==
X-Gm-Message-State: APjAAAWVwTNpEvnkXFb4wv5bGr4tuwmwi4VFD3Om83h2KMW5UlxupVKS
        6NbKBPvY4bf4e/Is/2oWpQo=
X-Google-Smtp-Source: APXvYqxDE7RJ2i6s8am7/VWRRZXy1R+AOldVj3UiB2rbBd+7FM7mAM0+8hLQWuYHVbKSkxcjIp5e4A==
X-Received: by 2002:adf:f3c1:: with SMTP id g1mr40412123wrp.203.1565606052462;
        Mon, 12 Aug 2019 03:34:12 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id i5sm7610442wrn.48.2019.08.12.03.34.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 03:34:11 -0700 (PDT)
Date:   Mon, 12 Aug 2019 12:34:10 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V15 00/13] PCI: tegra: Add Tegra194 PCIe support
Message-ID: <20190812103410.GO8903@ulmo>
References: <20190809044609.20401-1-vidyas@nvidia.com>
 <20190812102519.GN8903@ulmo>
 <aa666d78-43b3-dbea-dac6-386deaca3e12@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mvuFargmsA+C2jC8"
Content-Disposition: inline
In-Reply-To: <aa666d78-43b3-dbea-dac6-386deaca3e12@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--mvuFargmsA+C2jC8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 03:59:39PM +0530, Vidya Sagar wrote:
> On 8/12/2019 3:55 PM, Thierry Reding wrote:
> > On Fri, Aug 09, 2019 at 10:15:56AM +0530, Vidya Sagar wrote:
> > > Tegra194 has six PCIe controllers based on Synopsys DesignWare core.
> > > There are two Universal PHY (UPHY) blocks with each supporting 12(HSI=
O:
> > > Hisg Speed IO) and 8(NVHS: NVIDIA High Speed) lanes respectively.
> > > Controllers:0~4 use UPHY lanes from HSIO brick whereas Controller:5 u=
ses
> > > UPHY lanes from NVHS brick. Lane mapping in HSIO UPHY brick to each P=
CIe
> > > controller (0~4) is controlled in XBAR module by BPMP-FW. Since PCIe
> > > core has PIPE interface, a glue module called PIPE-to-UPHY (P2U) is u=
sed
> > > to connect each UPHY lane (applicable to both HSIO and NVHS UPHY bric=
ks)
> > > to PCIe controller
> > > This patch series
> > > - Adds support for P2U PHY driver
> > > - Adds support for PCIe host controller
> > > - Adds device tree nodes each PCIe controllers
> > > - Enables nodes applicable to p2972-0000 platform
> > > - Adds helper APIs in Designware core driver to get capability regs o=
ffset
> > > - Adds defines for new feature registers of PCIe spec revision 4
> > > - Makes changes in DesignWare core driver to get Tegra194 PCIe working
> > >=20
> > > Testing done on P2972-0000 platform
> > > - Able to get PCIe link up with on-board Marvel eSATA controller
> > > - Able to get PCIe link up with NVMe cards connected to M.2 Key-M slot
> > > - Able to do data transfers with both SATA drives and NVMe cards
> > > - Able to perform suspend-resume sequence
> >=20
> > Do you happen to have a patch for P2972-0000 PCI support? I don't see it
> > in this series.
> It is already merged.
> V10 link @ http://patchwork.ozlabs.org/patch/1114445/

D'oh! Indeed.

Thierry

--mvuFargmsA+C2jC8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1RQKIACgkQ3SOs138+
s6GLXg/8DOJVJ0fFXPAXXeHi86AGgUkBYnQUYPlOJXETCmROhZoJ5epgGbfRhQX9
QjEAXF7CNF6/FlU/0myVBYhGu+y2W5SkY+4dhOn1LLhTOS66MxNzuEvt7jMC7X6P
n8aOuS1nWlIjrTFRHRzwEQqLRIhhoInAo0Vyj+eOTUs3fk8eqDQ3pRLKx9BIJEwc
nhtoo5Dc15R7fHvBvwkP1349UHm6eodDr2Wo3tSa4IHj4QVpaaYhWpvujT7MvISU
dBznNBWqoLq7QAi3LFM/Wc0jgKZGriDnxQ2wKNbedDwmvF+FJsiBGlu+++Xg+enp
g/KKv9ZLMAWO0U8RD+j64NL6/325aBbaGZ+L1CFEscZPFuk7ivMspDAsMAjTqYOK
6X3QBqyHRUnHIHxKtYvnsI5U6e0y8lnjQCdnL6tNsq7qLdtHvC9o1xcMUeS/KOeM
TEPTztARXSzibsU5ebgDNX0Q/ioonwY5484gRPfNAmyOb+Vk0i8iCcZXlC6PpeZ5
GkF3LH8XAKBJ5QEoexe+o5qvZemQubl+hwrWViq1ySA8+3nHV0gEhkjt8dChfh/f
6NA0RMm3PyUtINdLP7kGOuZEc4ScNqszbsngqZuE/IgPj/2M5cWSzxnnad0OXG7R
0TnzLQG2M3PRP4bmxEb5jzTk+apORKyFOw6PKg+VkKACFN6P0F8=
=ZcJU
-----END PGP SIGNATURE-----

--mvuFargmsA+C2jC8--
