Return-Path: <linux-pci+bounces-1681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C508244BB
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 16:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67EA91F21930
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 15:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B1824206;
	Thu,  4 Jan 2024 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="B2V/7Luf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA3423755
	for <linux-pci@vger.kernel.org>; Thu,  4 Jan 2024 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4affeacaff9so186303e0c.3
        for <linux-pci@vger.kernel.org>; Thu, 04 Jan 2024 07:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704381218; x=1704986018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uo3GncCKNR0AkCV/1DPqjQ0hOppoX5B784xjEgiLIT0=;
        b=B2V/7Lufa01ra+BQx/BCUI+1EvXD+HJntVatc7ihvYQb3uyRveLNHeTF++ZjMZgjOv
         Qs5oTydMw9ifdMHzbvReE9Le8l+bbtchpxCxyYFrKiaJwJIb1sMUuVMU5bhBwdcjBROj
         Ue0cRmcuSHRxq9X1TQ1nc50Nno34utaFim19ldizvhbLMdu1HmSRgpvHZ+3xigYGQf6J
         C+r7UiHdsOcSxwk8f3EruqbT7NS+sEI94BEGEHztD3KvhYp02xS1hFlfLz2lh7diVcj0
         0yw3pQPVepL0+qabCdNwTo9gONEADVQzQMNB033E+O3Dlb0VzapjBxXDOgC5Kz2Wa0To
         Mo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704381218; x=1704986018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uo3GncCKNR0AkCV/1DPqjQ0hOppoX5B784xjEgiLIT0=;
        b=QPWyICf8z5Rs15hILgXf5pKnSfePMwnpxK124mCDXUj4Vq/H7j5KHCg83rAm8d99sf
         xDUeFBDArIV4MapxBYz4XHkxjIyg1F0/7W90jYGz5Dbx7lxsMF1QyNeu81m3rM+nM+l0
         w0IAtGKVYfzGcobAY3GQcGTnFHuJ6ZR9wqAgu9oR6DXXLk2VqEVF4rvX6QqObBtDvCHY
         GOHGFvm+iCi5eSDWkvQMulCMcUzhaDqEDREvP9Xxxt0EwKrjqdFs7dCX4G+ec6Mt3yZV
         nwIapuwZbIjQmVGci9lYUkC7CrR59u45C8u4rfkU0TOZeWSVlorc9g5XqWd0DNsR8yiL
         qziw==
X-Gm-Message-State: AOJu0YwlMCcToz/Lcu8lFTCXN6guRKrDW6p5Gesj7sbwJBDgTtyuLEK/
	y+LBFCp4oStnNu8QWPdI0oBlVYQ+DPHL8dT++bj1wfDKF3In2Q==
X-Google-Smtp-Source: AGHT+IGaU5XfoSCmXhPgB9dPZjVC5ipLctZH7E/xd+njpdt3eUTn/nDydi+QSdw8aSiqRs0d+1vMZ53MS8OTwZuJ5V8=
X-Received: by 2002:ac5:c9ab:0:b0:4b7:295d:a048 with SMTP id
 f11-20020ac5c9ab000000b004b7295da048mr619470vkm.29.1704381218190; Thu, 04 Jan
 2024 07:13:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104130123.37115-1-brgl@bgdev.pl> <20240104130123.37115-3-brgl@bgdev.pl>
 <CAA8EJpqZ8zbNcK1BsJaaoK3Fje9KhrvFvJpgdBa-US3eMhOmOw@mail.gmail.com>
In-Reply-To: <CAA8EJpqZ8zbNcK1BsJaaoK3Fje9KhrvFvJpgdBa-US3eMhOmOw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 4 Jan 2024 16:13:27 +0100
Message-ID: <CAMRc=McmhPMb9bykwKXmQ-1DL4sJW+7caXkxUq=8v16hT1k_oA@mail.gmail.com>
Subject: Re: [RFC 2/9] arm64: dts: qcom: qrb5165-rb5: describe the WLAN module
 of QCA6390
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
	Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <terry.bowman@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 2:44=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 4 Jan 2024 at 15:03, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Describe the ath11k WLAN on-board the QCA6390 module. Include the
> > relevant regulators and the enable GPIO.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot=
/dts/qcom/qrb5165-rb5.dts
> > index cd0db4f31d4a..721f86af952b 100644
> > --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > @@ -734,6 +734,22 @@ &pcie0_phy {
> >         vdda-pll-supply =3D <&vreg_l9a_1p2>;
> >  };
> >
> > +&pcieport0 {
> > +       wifi@0 {
> > +               compatible =3D "pci17cb,1101";
> > +               reg =3D <0x10000 0x0 0x0 0x0 0x0>;
> > +
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&wlan_en_state>;
> > +
> > +               enable-gpios =3D <&tlmm 20 GPIO_ACTIVE_HIGH>;
> > +
> > +               vddpmu-supply =3D <&vreg_s2f_0p95>;
> > +               vddpcie1-supply =3D <&vreg_s8c_1p3>;
> > +               vddpcie2-supply =3D <&vreg_s5a_1p9>;
>
> If I remember correctly, qca6390 has at least 8 power supplies AON,
> PMU, 3xRFA, 2xPCIe and VDDIO.
>
> Moreover, these bindings do not solve another problem: the PMU is
> shared between WiFi and BT parts. For the next gen (WCN6855) this
> becomes even more important, see the code in msm-5.10 which makes sure
> that there is a proper time between one of the units going down and
> another one being powered on.
>

Unified, shared power sequencing for this type of loosely coupled MFD
devices is something I have in mind and that will be orthogonal to
this. It will come on top of the PCIe power sequencing driver. I
wanted to address a simpler issue first.

Bartosz

> > +       };
> > +};
> > +
> >  &pcie1 {
> >         status =3D "okay";
> >  };
> > @@ -1303,6 +1319,14 @@ sdc2_card_det_n: sd-card-det-n-state {
> >                 function =3D "gpio";
> >                 bias-pull-up;
> >         };
> > +
> > +       wlan_en_state: wlan-default-state {
> > +               pins =3D "gpio20";
> > +               function =3D "gpio";
> > +               drive-strength =3D <16>;
> > +               output-low;
> > +               bias-pull-up;
> > +       };
> >  };
> >
> >  &uart6 {
> > --
> > 2.40.1
> >
> >
>
>
> --
> With best wishes
> Dmitry

