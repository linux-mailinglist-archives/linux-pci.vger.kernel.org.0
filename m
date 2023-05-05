Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4945B6F8500
	for <lists+linux-pci@lfdr.de>; Fri,  5 May 2023 16:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjEEOkv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 May 2023 10:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjEEOkt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 May 2023 10:40:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7942C18142
        for <linux-pci@vger.kernel.org>; Fri,  5 May 2023 07:40:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-307664010fdso1472406f8f.0
        for <linux-pci@vger.kernel.org>; Fri, 05 May 2023 07:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1683297633; x=1685889633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=08YqnhwKckRYmPmzUO8bnVCWw8G4TMM0luSy2M+ZPIY=;
        b=a6mJShvOC0LikjoE60yCjBpzl7wsLiytSjDLTRQAWFuCfCMcaciB+DoSvJraZmoiUj
         ikRMauxsCnY4sM8bpuUphd5t6k7weaS4q4pm5eMqhHRhezxQqPhWulBRZ45WIkugTBPd
         0MYpA3TSF4IcQk5t823Fzohf4qGytBErNQOPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683297633; x=1685889633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=08YqnhwKckRYmPmzUO8bnVCWw8G4TMM0luSy2M+ZPIY=;
        b=irzbhNmUB5TWZL57vgKfruaZyzGreWdvuWz6kWoOcAU3AWqCj2SXQ3NFbdo2exVX5N
         ZijaSkwG9Kyp1Ny2xYU99i6Vu5nz/fVZp4B9k/8GxhTF/sNw9GSKMvGmLeESxKJUU4L1
         ByXT0YMrS+xPw8cmjRhtsjt/WGgPXn0+uvT3mZz8nPcC3yJ+E/rRFjopbnpedCIZnmpc
         Ne3GsdGWFUQTWR2BCqby4ZqbFJzGfrpZZflDyRoVFxg4mFEB49OCOuMY1ru0EDATGy/u
         iTZ6MtpuCQOfMhVt/QKRygzPP9g2wGS4u1uwNfmPTfSGzdJBKk2bI5azUzs2gkoY7a0G
         Z2HA==
X-Gm-Message-State: AC+VfDwPWzfqWyR7uBmSsJn2sZc2NU61l0XR9XZ8istyiGjS1NZJ9hMK
        z6BLj++vG06TxZgEtU6dOTnNAVhDfmLKAOU3U9KWCA==
X-Google-Smtp-Source: ACHHUZ7/CMyAiyd5DCRH7WjoBBKdNjsCI4i0/Xp1r/dCZ0/OUTurYe31qzAJHdgCyae8XW5lX1C4FgHsrcZUe0uUces=
X-Received: by 2002:a05:6000:1362:b0:307:7dc6:cce4 with SMTP id
 q2-20020a056000136200b003077dc6cce4mr1619376wrz.32.1683297632781; Fri, 05 May
 2023 07:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <CA+-6iNzcCkxcrpugbWFafn1-SFcimjkLQaghY4TURCAuW032NA@mail.gmail.com>
 <20230505133412.GA943932@bhelgaas>
In-Reply-To: <20230505133412.GA943932@bhelgaas>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 5 May 2023 10:40:20 -0400
Message-ID: <CA+-6iNwH01ofONbD1Pgu5Y139JjEG7g6Lyt7vqkuXx2mm-Qf_Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: PCI: brcmstb: brcm,{enable-l1ss,completion-timeout-us}
 props
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007a241d05faf34583"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--0000000000007a241d05faf34583
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 5, 2023 at 9:34=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Fri, May 05, 2023 at 08:39:52AM -0400, Jim Quinlan wrote:
> > On Wed, May 3, 2023 at 6:18=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
> > > On Wed, May 03, 2023 at 05:38:15PM -0400, Jim Quinlan wrote:
> > > > On Wed, May 3, 2023 at 2:07=E2=80=AFPM Bjorn Helgaas <helgaas@kerne=
l.org> wrote:
> > > > > On Wed, May 03, 2023 at 10:38:57AM -0400, Jim Quinlan wrote:
> > > > > > On Sun, Apr 30, 2023 at 3:10=E2=80=AFPM Bjorn Helgaas <helgaas@=
kernel.org> wrote:
> > > > > > > On Fri, Apr 28, 2023 at 06:34:55PM -0400, Jim Quinlan wrote:
> > > > > > > > brcm,enable-l1ss (bool):
> > > > > > > >
> > > > > > > >   The Broadcom STB/CM PCIe HW -- a core that is also used b=
y RPi SOCs --
> > > > > > > >   requires the driver probe() to deliberately place the HW =
one of three
> > > > > > > >   CLKREQ# modes:
> > > > > > > >
> > > > > > > >   (a) CLKREQ# driven by the RC unconditionally
> > > > > > > >   (b) CLKREQ# driven by the EP for ASPM L0s, L1
> > > > > > > >   (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS=
).
> > > > > > > >
> > > > > > > >   The HW+driver can tell the difference between downstream =
devices that
> > > > > > > >   need (a) and (b), but does not know when to configure (c)=
.  All devices
> > > > > > > >   should work fine when the driver chooses (a) or (b), but =
(c) may be
> > > > > > > >   desired to realize the extra power savings that L1SS offe=
rs.  So we
> > > > > > > >   introduce the boolean "brcm,enable-l1ss" property to info=
rm the driver
> > > > > > > >   that (c) is desired.  Setting this property only makes se=
nse when the
> > > > > > > >   downstream device is L1SS-capable and the OS is configure=
d to activate
> > > > > > > >   this mode (e.g. policy=3D=3Dsuperpowersave).
>
> Just noticed that this should be "policy=3D=3Dpowersupersave"
>
> > > > > > > What bad things would happen if the driver always configured =
(c)?
> > > > > >
> > > > > > Well, our driver has traditionally only supported (b) and our
> > > > > > existing boards have been designed with this in mind.  I would =
not
> > > > > > want to switch modes w'o the user/customer/engineer opting-in t=
o do
> > > > > > so.  Further, the PCIe HW engineer told me defaulting to (c) wa=
s a
> > > > > > bad idea and was "asking for trouble".  Note that the commit's
> > > > > > comment has that warning about L1SS mode not meeting this 400ns
> > > > > > spec, and I suspect that many of our existing designs have bump=
ed
> > > > > > into that.
> > > > > >
> > > > > > But to answer your question, I haven't found a scenario that di=
d not
> > > > > > work by setting mode (c).  That doesn't mean they are not out t=
here.
> > > > > >
> > > > > > > Other platforms don't require this, and having to edit the DT
> > > > > > > based on what PCIe device is plugged in seems wrong.  If brcm=
stb
> > > > > > > does need it, that suggests a hardware defect.  If we need th=
is to
> > > > > > > work around a defect, that's OK, but we should acknowledge th=
e
> > > > > > > defect so we can stop using this for future hardware that doe=
sn't
> > > > > > > need it.
> > > > > >
> > > > > > All devices should work w/o the user having to change the DT.  =
Only
> > > > > > if they desire L1SS must they add the "brcm,enable-l1ss" proper=
ty.
> > > > >
> > > > > I thought the DT was supposed to describe properties of the
> > > > > *hardware*, but this seems more like "use this untested clkreq
> > > > > configuration," which maybe could be done via a module parameter?
> > > >
> > > > Electrically, it has been tested, but  specifically for L1SS capabl=
e
> > > > devices.  What is untested AFAICT are platforms using this mode on
> > > > non-L1SS capable devices.
> > >
> > > Non-L1SS behavior is a subset of L1SS, so if you've tested with L1SS
> > > enabled, I would think you'd be covered.
>
> I think this point is still worth considering.  Maybe your hardware
> folks have an opinion here?
See below.
>
> > > But I'm not a hardware engineer, so maybe there's some subtlety there=
.
> > > The "asking for trouble" comment from your engineer is definitely
> > > concerning, but I have no idea what's behind that.
> > >
> > > And obviously even if we have "brcm,enable-l1ss", the user may decide
> > > to disable L1SS administratively, so even if the Root Port and the
> > > device both support L1SS, it may be never be enabled.
> > >
> > > > WRT bootline param
> > > > pci=3D[<domain>:]<bus>:<dev>.<func>[/<dev>.<func>]*pci:<vendor>:<de=
vice>[:<subvendor>:<subdevice>]:
> > > > this does not look compatible for vendor specific DT options like
> > > > "brcm,enable-l1ss".  I observe that pci_dev_str_match_path() is a
> > > > static function and I don't see a single option in pci.c  that is
> > > > vendor specific.  FWIW, moving something like this to the bootline
> > > > would not be popular with our customers; for some reason they reall=
y
> > > > don't like changes to the bootline.
> > >
> > > They prefer editing the DT?
> > >
> > > I agree the "pci=3DB:D.F" stuff is a bit ugly.  Do you have multiple
> > > slots such that you would have to apply this parameter to some but no=
t
> > > others?  I guess I was imagining a single-slot system where you
> > > wouldn't need to identify the specific device because there *is* only
> > > one.
> >
> > We typically have a single device per controller.  Occasionally,
> > there is a mismatch in needs, and the customer adds a switch to
> > their board until we can add another controller to the next rev of
> > the SOC.
>
> If you add a switch, it sounds like there's still only a single link
> between the brcmstb controller and the switch.  I'm assuming
> "brcm,enable-l1ss" only affects CLKREQ# on that link and it has
> nothing to do with links below the switch.
>
> (c) must be the standard PCIe situation because no other systems
> require the user to configure CLKREQ# based on the type of card
> plugged in.  And we don't know about any actual problems that happen
> in (c) with any cards.
>
> That makes me think the ideal end state would be to use (c) by
> default so everything just works like every other platform with no
> fuss.  If there's some situation that requires (a) or (b), there could
> be a property or parameter to select *that* because that would be the
> unusual case.
>
> But obviously the comment from the hardware engineer:
>
> > > > > > Further, the PCIe HW engineer told me defaulting to (c) was
> > > > > > a bad idea and was "asking for trouble".
>
> would need to be understood before doing that.

Keep in mind that our controller is already unusual in that it
requires this manual mode setting whereas
other controllers don't seem to have this issue.  As far as discussing
this with the HW person, either I am not understanding the reason(s)
or he is not explaining them well.  We've tried a couple of times,
FWIW.   At any rate,  one thing he has repeated with emphasis  is that
only l1ss capable devices should be using our l1ss mode.
For me, this feedback  trumps all other choices.

Finally, experience has made me quite wary of silently changing a
default for all of our STB/CM existing customers, regardless of the
fact that the CM4 Raspian folks have been using l1ss-mode (most likely
as a workaround to boot with cards lacking a functional CLKREQ# pin).

Regards.
Jim Quinlan
Broadcom STB

>
> Bjorn

--0000000000007a241d05faf34583
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCZZ0G9mV+/OpUHspGwk3CmzRE2NW2a
GVr4JBKbI5iLfTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzA1
MDUxNDQwMzNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAC2yxYpOIlmWWHGpauuSgI75/FX7jmsztCrCD0jTfvEWLw16h
wsCsToPBKO6WuRlwgcx0khklvLxg1kkMclSfVgmSfEhd3U2+LHqzLsLMkGrWDwwukt4HZyQR4jM/
2qFiMVxo1KwougL0rB9DZx5jaQQ5oh0V4u21M8sw0lwTteyIEFnRM2zftx60dHtLFZrl+puxTZNv
5yGKOsxWczBbOCfMx9dcUz0x/gYVVhD0tAUTjeyQOhzI5tTvaA0V9exG2x7qXegHlLtCdXdgxYEr
FaCgxJphUQz64acd6xdiR7Vz1Uhi8xWpZx1kNn5+gSysaB6Vy6RAOjj8sF6gtd+rRg==
--0000000000007a241d05faf34583--
