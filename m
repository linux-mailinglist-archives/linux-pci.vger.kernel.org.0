Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7143D785B5A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 17:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbjHWPCm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 11:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbjHWPCl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 11:02:41 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78077101
        for <linux-pci@vger.kernel.org>; Wed, 23 Aug 2023 08:02:38 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so61977561fa.3
        for <linux-pci@vger.kernel.org>; Wed, 23 Aug 2023 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692802957; x=1693407757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uxl3rXsQrsxwF56b0BDlzdAZ7CMa3hnZ6VO/JHiVBRU=;
        b=E4L6hyUq2TmMy/QaHoIT6DvBr95KqiM5WXbigwXhhN+zA0lkiIEPgoyNy3dIOwpYj5
         3Y+4A4n3RI97EAROdD21IiHkxwQI68/tFcJ/ajxbxqNg+MBsdj8FRI2fI3SK2Ph5gTX9
         Mbdp4nNcdxbpV7JR+YpEgL6vQmOOXT8h3JoM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692802957; x=1693407757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uxl3rXsQrsxwF56b0BDlzdAZ7CMa3hnZ6VO/JHiVBRU=;
        b=VSYyChlpjmg1iUC98FnO4PDBrRBp1kJVVYWzdMfOATiuHjnqK/8qSlQfBGSr2Ws/DO
         KGGp+ZAkHnkVkkiPWXAcWNch87jK5SvvBd3/vOExdsRyp3D8ZmyQ96rh4Me0vb4dGZjv
         LAIaEZRHwLqm/y5oLPqtdpSrC8kWyrv5Xa+oVVswLpABm0i8jXezrxYLDkA3AmaLlbqd
         8zyDR6rQ8jIv/Kaigr1rKrLZHDmyeLYS+TJtdBGUiLhXdofJ9ARs5pcenBSwN9/PqTQ5
         yl4uXHNt/3sUClrnDLXCf2W49T8zlmv7P1v6my4htBh/jRZgg9s2syOo0WPtccZ+vF1u
         qSYg==
X-Gm-Message-State: AOJu0YwemIHKvFfXg/3q8EbkR41ZaeXkMVeZjtVRVnylfSChixgH8xgl
        jZD1IFJdEtDcefDVGuFxXdVhzYHJFGZk98O2gp7S/g==
X-Google-Smtp-Source: AGHT+IHAcE7/SdOVkLgucoI+3LaIuwNnjrd2t6Ew6XART6LzQuhKxSe2rFrT3PeJs0O1j2aOZ2fRa2n5j+pPjv3syFY=
X-Received: by 2002:a2e:9ad8:0:b0:2b7:3b6c:a5e4 with SMTP id
 p24-20020a2e9ad8000000b002b73b6ca5e4mr11167135ljj.38.1692802956563; Wed, 23
 Aug 2023 08:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <ZOW1qDmTdy+8KODt@lpieralisi> <20230823124214.GA416689@bhelgaas>
In-Reply-To: <20230823124214.GA416689@bhelgaas>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 23 Aug 2023 11:02:24 -0400
Message-ID: <CA+-6iNxMYdKGaGpQPgKf_ptAAryi0nEOadVk9AwMLrbUrR67uA@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] dt-bindings: PCI: brcmstb: Add brcm,enable-l1ss property
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000edc25c0603986673"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000edc25c0603986673
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 8:42=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Wed, Aug 23, 2023 at 09:30:48AM +0200, Lorenzo Pieralisi wrote:
> > On Mon, Aug 21, 2023 at 12:01:50PM -0400, Jim Quinlan wrote:
> > > On Mon, Aug 21, 2023 at 11:41=E2=80=AFAM Lorenzo Pieralisi
> > > <lpieralisi@kernel.org> wrote:
> > > > On Mon, Aug 21, 2023 at 11:25:11AM -0400, Jim Quinlan wrote:
> > > > > On Mon, Aug 21, 2023 at 10:47=E2=80=AFAM Lorenzo Pieralisi
> > > > > <lpieralisi@kernel.org> wrote:
> > > > > > On Fri, Jun 23, 2023 at 10:40:54AM -0400, Jim Quinlan wrote:
> > > > > > > This commit adds the boolean "brcm,enable-l1ss" property:
> > > > > > >
> > > > > > >   The Broadcom STB/CM PCIe HW -- a core that is also used by =
RPi SOCs --
> > > > > > >   requires the driver probe() to deliberately place the HW on=
e of three
> > > > > > >   CLKREQ# modes:
> > > > > > >
> > > > > > >   (a) CLKREQ# driven by the RC unconditionally
> > > > > > >   (b) CLKREQ# driven by the EP for ASPM L0s, L1
> > > > > > >   (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS).
> > > > > > >
> > > > > > >   The HW+driver can tell the difference between downstream de=
vices that
> > > > > > >   need (a) and (b), but does not know when to configure (c). =
 All devices
> > > > > > >   should work fine when the driver chooses (a) or (b), but (c=
) may be
> > > > > > >   desired to realize the extra power savings that L1SS offers=
.  So we
> > > > > > >   introduce the boolean "brcm,enable-l1ss" property to inform=
 the driver
> > > > > > >   that (c) is desired.  Setting this property only makes sens=
e when the
> > > > > > >   downstream device is L1SS-capable and the OS is configured =
to activate
> > > > > > >   this mode (e.g. policy=3D=3Dpowersupersave).
> > > > > > >
> > > > > > >   This property is already present in the Raspian version of =
Linux, but the
> > > > > > >   upstream driver implementation that follows adds more detai=
ls and
> > > > > > >   discerns between (a) and (b).
> > > > > > >
> > > > > > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > > > ---
> > > > > > >  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 9=
 +++++++++
> > > > > > >  1 file changed, 9 insertions(+)
> > > > > > >
> > > > > > > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-p=
cie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > > > index 7e15aae7d69e..8b61c2179608 100644
> > > > > > > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yam=
l
> > > > > > > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yam=
l
> > > > > > > @@ -64,6 +64,15 @@ properties:
> > > > > > >
> > > > > > >    aspm-no-l0s: true
> > > > > > >
> > > > > > > +  brcm,enable-l1ss:
> > > > > > > +    description: Indicates that PCIe L1SS power savings
> > > > > > > +      are desired, the downstream device is L1SS-capable, an=
d the
> > > > > > > +      OS has been configured to enable this mode.  For board=
s
> > > > > >
> > > > > > What does this mean ? I don't think DT properties are supposed
> > > > > > to carry information related to how the OS is configured.
> > > > >
> > > > > The DT setting in question is unrelated to the statement "and the=
 OS
> > > > > has been configured to
> > > > > enable this mode".
> > > > >
> > > > > This is merely saying that even if you enable "brcm,l1ss-enable"
> > > > > that you may not get L1SS power savings w/o setting
> > > > > "CONFIG_PCIEASPM_POWER_SUPERSAVE=3Dy".
> > > > > I mentioned that exact term but a reviewer nakked it because
> > > > > apparently DT descriptions should not be OS specific.
> > > > >
> > > > > I am actually open for this to be a command-line option but I wan=
ted to honor
> > > > > what the Raspian OS folks have already done.  RaspianOS already h=
as
> > > > > "brcm,enable-l1ss"
> > > > > set in their DTS files.
> > > >
> > > > This is about the mainline kernel, I don't have any visibility into
> > > > downstream kernels (where that property management was added withou=
t DT
> > > > and PCI maintainers supervision).
> > > >
> > > > Raspian OS folks' choice is theirs but it can't and it shouldn't ov=
erride
> > > > the mainline review process even though I understand the position y=
ou
> > > > are in.
> > >
> > > Understood, but using the command line has its warts as well; I now r=
ecall the
> > > discussion Bjorn and I  had regarding this option.  I'm pretty sure
> > > that upstreaam will not allow the following
> > > possible command line kernel params:
> > >
> > >     brcm,enable-l1ss
> > >     pci=3Dbrcm,entable-l1ss
> > >
> > > Bjorn suggested using the  documented but (IMO) obscure  and  rarely
> > > used  format
> > >
> > >     pci=3D[<domain>:]<bus>:<dev>.<func>[/<dev>.<func>]*pci:<vendor>:<=
device>[:<subvendor>:<subdevice>]
> > >
> > > but this is just going in the wrong direction; here's why.  Using the
> > > above iformat s completely dependent on the
> > > PCI "linux-domaiin"  property,  a non-HW related DT property I  might
> > > add.  Since "linux-domain" is already
> > > a valid and well-used  DT property, and the value of  the above
> > > command line format is dependent
> > > on the value of the "linux-domain", why not be consistent and let
> > > "brcm,enable-l1ss" be a Broadcom specific property?
> >
> > I am just asking to add a module_param to the host controller driver.

Adding a module_param, which would have a command line setting such as
"brcm_pcie.enable-l1ss=3D1"
is for the driver -- we need a per PCIe controller param, as each
controller may have a different setting.

Which brings us to the alternative, a command line param using
pci_dev_str_match() such as

      pci=3Dbrcm,enable-l1ss=3D1:0:0.0

Implementing this would require this AFAICT:

    (1) New file:  drivers/pci/controller/pcie-brcmstb.h
    (2) The "pci.c" file would have to include the above file which I
don't think is a good thing.

>
> A module_param sounds possible to me.  IIRC the bidirectional CLKREQ#
> (config (c)) has been tested and there are no known problems even if
> the OS doesn't enable L1SS.

Ah, I have an update on this.  I was able to communicate with the HW
designer and he explained
that when setting the PCIe core "l1ss bit"  one  loses the benefit  of
Clock Power  Management.  Actually,
let me quote his email so I do not distort his words:

   "If RC is placed in L1SS clkreq mode, may take advantage
    of L1SS power savings, L0s, and L1 power savings, but cannot
    employ Clock Power Management power savings.

    If the RC is placed in "clkreq" clkreq mode, it can only take
    advantage of L0s, L1 power savings, and Clock Power Management
    savings - only omitting L1SS power savings

    The issue is that the Clock Power Management and PM L1 Substates
    are incompatible. The original Clock Power Management feature
    requires the clock to turn on within Tclron=3D400ns from CLKREQ#
    deassertion, and we feel we need to continue to support products
    that were designed to this requirement. The CLKREQ# deassertion
    to clock turned on requirement with PM L1 Substates was relaxed
    with the addition of the Latency Tolerance Reporting (LTR)
    mechanism. We use the mode bit to distinguish the two modes of
    operation, but currently we aren't looking at whether the RC+EP
    both support the LTR mechanism to make the decision."

I'm not sure if this changes your mind one way or another.

Regards,
Jim Quinlan
Broadcom STB/CM





The only issue (again, IIRC) is that the
> hardware engineer has unspecified reservations about it.
>
> Is there any room to make (c) the default and have a module_param to
> *disable* the L1SS support?  I think the driver knows enough to then
> select (a) or (b) by itself.
>
> Bjorn

--000000000000edc25c0603986673
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQbgYJKoZIhvcNAQcCoIIQXzCCEFsCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3FMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBU0wggQ1oAMCAQICDEjuN1Vuw+TT9V/ygzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE3MTNaFw0yNTA5MTAxMjE3MTNaMIGO
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFDASBgNVBAMTC0ppbSBRdWlubGFuMSkwJwYJKoZIhvcNAQkB
FhpqYW1lcy5xdWlubGFuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAKtQZbH0dDsCEixB9shqHxmN7R0Tywh2HUGagri/LzbKgXsvGH/LjKUjwFOQwFe4EIVds/0S
hNqJNn6Z/DzcMdIAfbMJ7juijAJCzZSg8m164K+7ipfhk7SFmnv71spEVlo7tr41/DT2HvUCo93M
7Hu+D3IWHBqIg9YYs3tZzxhxXKtJW6SH7jKRz1Y94pEYplGQLM+uuPCZaARbh+i0auVCQNnxgfQ/
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBOx7aUuB8utUizge8GWhNQxej5+ibZ
OKuIw382dfK50jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzA4
MjMxNTAyMzdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAZBoNqXdDQFJdNulh66itqu7T7dzNX57ZRZKMbM0AEeZl9+Tk
WhXSnw6/BlyemPIxBbuqa44fo+LVHopSwd3ohxQkgVPAzLYPG1DzKbrmQmkOMPJu4xllfllA6KT2
nK1fnoeMKiClr58WGfKJwu5wdJ8L17evKsmuX5egd+CrvDVjoGtYUIGTjWZf2eyQK3U9udiQlNg1
2rnfIj+KGwJucGgnwV4L551vAs7CpnkT3YISXJjQ3W5ea0XCrg2VwQ/6CRReagIfIb8azymZpYa1
ixtRFuK7/WEfMHlb428oBd+G0fd/0vS4NztzFaeMgJdeQYQOYMiaT49+4U53rSpQlQ==
--000000000000edc25c0603986673--
